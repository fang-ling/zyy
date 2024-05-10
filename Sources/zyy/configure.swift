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
var TOKEN_EXPIRATION_MINUTES = 43200.0

public func configure(_ app: Application) async throws {
  if app.environment == .testing {
    app.databases.use(.sqlite(.memory), as: .sqlite)
  } else {
    app.databases.use(
      DatabaseConfigurationFactory.sqlite(.file("zyy.sqlite")),
      as: .sqlite
    )
  }
  
  app.middleware.use(FileMiddleware(publicDirectory: "output"))
  
  app.migrations.add(Reaction.CreateReactions())
  
  app.migrations.add(User.CreateUsers())
  app.migrations.add(UserToken.CreateUserTokens())
  
  app.migrations.add(Page.CreatePages())
  
  try await app.autoMigrate()
  
  try routes(app)
}
