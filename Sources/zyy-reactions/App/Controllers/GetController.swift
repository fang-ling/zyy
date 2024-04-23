//
//  GetController.swift
//
//
//  Created by Fang Ling on 2024/4/23.
//

import Fluent
import Vapor

struct GetController : RouteCollection {
  func boot(routes : RoutesBuilder) throws {
    routes.grouped("get").get(use: get_handler)
  }
  
  func get_handler(req : Request) async throws -> Reaction {
    guard let slug = req.query[String.self, at: "slug"] else {
      return Reaction(
        slug: "",
        emoji_1: -2,
        emoji_2: -2,
        emoji_3: -2,
        emoji_4: -2
      )
    }
    
    let ret = try await Reaction.query(on: req.db).filter(\.$slug == slug).all()
    
    guard let reaction = ret.first else {
      return Reaction(
        slug: "",
        emoji_1: -1, 
        emoji_2: -1,
        emoji_3: -1,
        emoji_4: -1
      )
    }
    
    return reaction
  }
}

