//
//  configure.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor
import Fluent
import FluentSQLiteDriver

let USER_REGISTRATION_LIMIT = 1

public func configure(_ app: Application) async throws {
  if app.environment == .testing {
    app.databases.use(.sqlite(.memory), as: .sqlite)
  } else {
    app.databases.use(
      DatabaseConfigurationFactory.sqlite(.file("zyy.sqlite")),
      as: .sqlite
    )
  }
  
  app.migrations.add(Reaction.CreateReactions())
  app.migrations.add(User.CreateUsers())
  
  try await app.autoMigrate()
  
  try routes(app)
}
