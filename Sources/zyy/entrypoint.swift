//
//  entrypoint.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor

let VERSION = "1.0.0"
let GITHUB_LINK = "https://github.com/fang-ling/zyy/"

@main
enum Entrypoint {
  static func main() async throws {
    var env = try Environment.detect()
    try LoggingSystem.bootstrap(from: &env)
    
    let app = Application(env)
    defer {
      app.shutdown()
    }
    
    app.asyncCommands.use(VersionCommand(), as: "version")
    app.asyncCommands.use(BuildCommand(), as: "build")
    
    do {
      try await configure(app)
    } catch {
      app.logger.report(error: error)
      throw error
    }
    try await app.execute()
  }
}
