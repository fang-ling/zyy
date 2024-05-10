//
//  configure.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor
import Fluent
import FluentSQLiteDriver
import Foundation

let USER_REGISTRATION_LIMIT = 1
var TOKEN_EXPIRATION_MINUTES = 43200.0
let PUBLIC_DIRECTORY = "Public"
let VERSION = "1.0.0"
let GITHUB_LINK = "https://github.com/fang-ling/zyy/"

public func configure(_ app: Application) async throws {
  if app.environment == .testing {
    app.databases.use(.sqlite(.memory), as: .sqlite)
  } else {
    app.databases.use(
      DatabaseConfigurationFactory.sqlite(.file("zyy.sqlite")),
      as: .sqlite
    )
  }
  
  try build_server_front_end()
  
  app.middleware.use(FileMiddleware(publicDirectory: PUBLIC_DIRECTORY))
  
  app.migrations.add(Reaction.CreateReactions())
  
  app.migrations.add(User.CreateUsers())
  app.migrations.add(UserToken.CreateUserTokens())
  
  app.migrations.add(Page.CreatePages())
  
  try await app.autoMigrate()
  
  try routes(app)
}

fileprivate func build_server_front_end() throws {
  try FileManager.default.createDirectory(
    atPath: PUBLIC_DIRECTORY,
    withIntermediateDirectories: true
  )
  
  let main_style_url = Bundle.module.url(
    forResource: "zyy",
    withExtension: "css"
  )!
  let main_js_url = Bundle.module.url(
    forResource: "zyy",
    withExtension: "js"
  )!
  
  try String(contentsOf: main_style_url).write(
    toFile: PUBLIC_DIRECTORY + "/zyy.css",
    atomically: true,
    encoding: .utf8
  )
  try String(contentsOf: main_js_url).write(
    toFile: PUBLIC_DIRECTORY + "/zyy.js",
    atomically: true,
    encoding: .utf8
  )
  
  try IndexView().description.write(
    toFile: PUBLIC_DIRECTORY + "/index.html",
    atomically: true,
    encoding: .utf8
  )
  try LoginView().description.write(
    toFile: PUBLIC_DIRECTORY + "/login.html",
    atomically: true,
    encoding: .utf8
  )
  try SignupView().description.write(
    toFile: PUBLIC_DIRECTORY + "/signup.html",
    atomically: true,
    encoding: .utf8
  )
}
