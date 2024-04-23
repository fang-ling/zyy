//
//  AddController.swift
//
//
//  Created by Fang Ling on 2024/4/23.
//

import Fluent
import FluentSQL
import Vapor
import SQLKit

struct AddController : RouteCollection {
  func boot(routes : RoutesBuilder) throws {
    routes.grouped("add").get(use: add_handler)
  }
  
  func add_handler(req : Request) async throws -> HTTPStatus {
    guard let slug = req.query[String.self, at: "slug"],
          let emoji = req.query[String.self, at: "emoji"] else {
      /* no slug or emoji */
      return .badRequest
    }

/* The following code looks silly. Maybe there is a better way to do this. */
/*----------------------------------------------------------------------------*/
    guard
      let reaction = try await Reaction.query(on: req.db)
        .filter(\.$slug == slug)
        .all()
        .first
    else {
      return .badRequest
    }
    
    let new_reaction = Reaction(
      slug: reaction.slug,
      emoji_1: reaction.emoji_1,
      emoji_2: reaction.emoji_2,
      emoji_3: reaction.emoji_3,
      emoji_4: reaction.emoji_4
    )
    
    try await Reaction.query(on: req.db).filter(\.$slug == slug).delete()
    
    if emoji.last == "1" {
      new_reaction.emoji_1 += 1
    } else if emoji.last == "2" {
      new_reaction.emoji_2 += 1
    } else if emoji.last == "3" {
      new_reaction.emoji_3 += 1
    } else {
      new_reaction.emoji_4 += 1
    }
    
    try await new_reaction.save(on: req.db)
/*----------------------------------------------------------------------------*/
    
    return .ok
  }
}
