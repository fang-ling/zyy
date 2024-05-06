//
//  ReactionController.swift
//
//
//  Created by Fang Ling on 2024/4/23.
//

import Fluent
import Vapor
import SQLKit

/*
 * +--------+--------------------+--------+-----------------------------------+
 * | Method |        Routes      | Authen |            Description            |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   200: Return reaction            |
 * | GET    | /reaction?id       | None   | Error:                            |
 * |        |                    |        |   400: Invalid page id            |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        | /reaction?id       |        |   200: Increase emoji by one      |
 * | PATCH  | &emoji             | None   | Error:                            |
 * |        |                    |        |   400: Invalid page id or emoji   |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   201: Create new reaction        |
 * |        |                    |        | Error:                            |
 * | POST   | /reaction?id       | Bearer |   400: Invalid page id            |
 * |        |                    |        |   401: Unauthorized               |
 * |        |                    |        |   403: Author mismatch            |
 * |        |                    |        |   409: Duplicate reactions        |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   200: Return reaction list       |
 * | GET    | /reactions         | Bearer | Error:                            |
 * |        |                    |        |   401: Unauthorized               |
 * +--------+--------------------+--------+-----------------------------------+
 */
struct ReactionController : RouteCollection {
  func boot(routes : RoutesBuilder) throws {
    routes.group("reaction") { reaction in
      reaction.get(use: read_reaction_handler)
      reaction.patch(use: update_reaction_handler)
      reaction
        .grouped(UserToken.authenticator())
        .post(use: create_reaction_handler)
    }
    routes.group("reactions") { reactions in
      reactions
        .grouped(UserToken.authenticator())
        .get(use: read_reactions_handler)
    }
  }
  
  func read_reaction_handler(req : Request) async throws -> Reaction {
    guard let id = req.query[UUID.self, at: "id"] else {
      throw Abort(.badRequest, reason: "No id found in URL query")
    }
    
    let ret = try await Reaction
      .query(on: req.db)
      .filter(\.$page.$id == id)
      .all()
    
    guard let reaction = ret.first else {
      throw Abort(.badRequest, reason: "No such reaction with page_id: \(id)")
    }
    
    return reaction
  }
  
  func update_reaction_handler(req : Request) async throws -> HTTPStatus {
    guard let id = req.query[UUID.self, at: "id"],
          let emoji = req.query[Int.self, at: "emoji"] else {
      throw Abort(.badRequest, reason: "No id or emoji found in URL query")
    }

    if emoji < 1 || emoji > 4 {
      throw Abort(.badRequest, reason: "Emoji out of bound")
    }
    let ret = try await Reaction
      .query(on: req.db)
      .filter(\.$page.$id == id)
      .all()
    if ret.isEmpty {
      throw Abort(.badRequest, reason: "No such reaction with page_id: \(id)")
    }
    
    /* Evaluate the raw SQL */
    let SQL =
      """
      UPDATE "Reactions" SET "emoji_\(emoji)" = "emoji_\(emoji)" + 1
      WHERE ("page_id" = '\(id)');
      """
    guard let sql_database = req.db as? SQLDatabase else {
      throw Abort(.internalServerError, reason: "Raw SQL failed")
    }
    try await sql_database.raw(SQLQueryString(SQL)).run()
    
    return .ok
  }
  
  func create_reaction_handler(req : Request) async throws -> HTTPStatus {
    let user = try req.auth.require(User.self)
    
    guard let id = req.query[UUID.self, at: "id"] else {
      throw Abort(.badRequest, reason: "No id found in URL query")
    }
    
    let ret = try await Page
      .query(on: req.db)
      .filter(\.$id == id)
      .all()
    guard let page = ret.first else {
      throw Abort(.badRequest, reason: "No such page with id: \(id)")
    }
    if page.$user.id != user.id {
      throw Abort(.forbidden, reason: "Author mismatch")
    }
    
    let reaction = Reaction(page_id: id)
    do {
      try await reaction.save(on: req.db)
    } catch {
      throw Abort(
        .conflict,
        reason: "Duplicate reaction violates unique constraint "
      )
    }
    
    return .created
  }
  
  func read_reactions_handler(req : Request) async throws -> [Reaction.List] {
    try req.auth.require(User.self)
    
    return try await Reaction
      .query(on: req.db)
      .with(\.$page)
      .all()
      .map({
        Reaction.List(
          page_link: $0.page.link,
          emoji_1: $0.emoji_1,
          emoji_2: $0.emoji_2,
          emoji_3: $0.emoji_3,
          emoji_4: $0.emoji_4
        )
      })
  }
}

