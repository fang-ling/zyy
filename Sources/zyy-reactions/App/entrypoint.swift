//
//  entrypoint.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor

@main
enum Entrypoint {
  static func main() async throws {
    var env = try Environment.detect()
    try LoggingSystem.bootstrap(from: &env)
    
    let app = Application(env)
    defer {
      app.shutdown()
    }
    
    do {
      try await configure(app)
    } catch {
      app.logger.report(error: error)
      throw error
    }
    try await app.execute()
  }
}
