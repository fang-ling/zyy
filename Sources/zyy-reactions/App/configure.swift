//
//  configure.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) async throws {
  app.databases.use(
    DatabaseConfigurationFactory.sqlite(.file("zyy.sqlite")),
    as: .sqlite
  )
  
  app.migrations.add(Reaction.TableCreation())
  
  try routes(app)
}
