//
//  CreateUsers.swift
//
//
//  Created by Fang Ling on 2024/5/3.
//

import Fluent
import Foundation

extension User {
  struct CreateUsers: AsyncMigration {
    var name: String { "Create Users Table" }
    
    func prepare(on database: Database) async throws {
      try await database.schema("Users")
        .id()
        .field("first_name", .string, .required)
        .field("last_name", .string, .required)
        .field("birthday", .date, .required)
        .field("avatar", .string)
        .field("email", .string, .required)
        .field("password_hash", .string, .required)
        .field("registered_at", .date, .required)
        .field("link", .string, .required)
        .create()
    }
    
    func revert(on database: Database) async throws {
      try await database.schema("Users").delete()
    }
  }
}
