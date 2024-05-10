//
//  PageController.swift
//
//
//  Created by Fang Ling on 2024/5/5.
//

import Fluent
import Vapor

/*
 * +--------+--------------------+--------+-----------------------------------+
 * | Method |        Routes      | Authen |            Description            |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   201: Create new page            |
 * | POST   | /api/page          | Bearer | Error:                            |
 * |        |                    |        |   400: Invalid page form          |
 * |        |                    |        |   401: Unauthorized               |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   200: Return the page list       |
 * | GET    | /api/pages         | Bearer | Error:                            |
 * |        |                    |        |   401: Unauthorized               |
 * +--------+--------------------+--------+-----------------------------------+
 */
struct PageController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.group("api") { api in
      api.group("page") { page in
        page
          .grouped(UserToken.authenticator())
          .post(use: create_page_handler)
      }
      api.group("pages") { pages in
        pages
          .grouped(UserToken.authenticator())
          .get(use: read_pages_handler)
      }
    }
  }
  
  func create_page_handler(req: Request) async throws -> HTTPStatus {
    let user = try req.auth.require(User.self)
    
    try Page.Create.validate(content: req)
    let create = try req.content.decode(Page.Create.self)
    
    let page = Page(
      title: create.title,
      content: create.content,
      link: create.link,
      artwork: create.artwork,
      caption: create.caption,
      user_id: user.id!,
      is_hidden: create.is_hidden,
      is_blog_article: create.is_blog_article
    )
    
    try await page.save(on: req.db)
    
    return .created
  }
  
  func read_pages_handler(req: Request) async throws -> [Page.List] {
    let user = try req.auth.require(User.self)
    
    return try await Page
      .query(on: req.db)
      .filter(\.$user.$id == user.id!)
      .all()
      .map({
        Page.List(
          id: $0.id!,
          title: $0.title,
          created_at: $0.created_at!,
          modified_at: $0.modified_at!
        )
      })
  }
}
