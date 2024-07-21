//
//  CreatePages.swift
//
//
//  Created by Fang Ling on 2024/5/4.
//

import Foundation
import Fluent

extension Page {
  struct CreatePages: AsyncMigration {
    var name: String { "Create Pages Table" }
    
    func prepare(on database: Database) async throws {
      try await database.schema("Pages")
        .id()
        .field("title", .string, .required)
        .field("content", .string, .required)
        .field("link", .string, .required)
        .field("artwork", .string, .required)
        .field("caption", .string, .required)
        .field("user_id", .uuid, .required, .references("Users", "id"))
        .field("created_at", .date, .required)
        .field("modified_at", .date, .required)
        .field("is_hidden", .bool, .required)
        .field("is_blog_article", .bool, .required)
        .create()
    }
    
    func revert(on database: Database) async throws {
      try await database.schema("Pages").delete()
    }
  }
}
