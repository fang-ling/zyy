//
//  CreateUserTokens.swift
//
//
//  Created by Fang Ling on 2024/5/4.
//

import Foundation
import Fluent

extension UserToken {
  struct CreateUserTokens: AsyncMigration {
    var name: String { "Create UserTokens Table" }
    
    func prepare(on database: Database) async throws {
      try await database.schema("UserTokens")
        .id()
        .field("value", .string, .required)
        .field("expires_at", .datetime, .required)
        .field("user_id", .uuid, .required, .references("Users", "id"))
        .create()
    }
    
    func revert(on database: Database) async throws {
      try await database.schema("UserTokens").delete()
    }
  }
}
