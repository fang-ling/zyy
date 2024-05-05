//
//  CreateReactions.swift
//
//
//  Created by Fang Ling on 2024/4/23.
//

import Fluent
import Foundation

extension Reaction {
  struct CreateReactions : AsyncMigration {
    var name : String { "Create Reactions Table" }
    
    func prepare(on database: Database) async throws {
      try await database.schema("Reactions")
        .id()
        .field("page_id", .uuid, .required, .references("Pages", "id"))
        .field("emoji_1", .int, .required)
        .field("emoji_2", .int, .required)
        .field("emoji_3", .int, .required)
        .field("emoji_4", .int, .required)
        .unique(on: "page_id")
        .create()
    }
    
    func revert(on database: Database) async throws {
      try await database.schema("Reactions").delete()
    }
  }
}
