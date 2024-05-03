//
//  AuthenticationTests.swift.
//
//
//  Created by Fang Ling on 2024/5/3.
//

@testable import zyy_reactions
import Foundation
import Fluent
import XCTVapor

final class AuthenticationTests: XCTestCase {
  func test_register() async throws {
    let app = Application(.testing)
    defer {
      app.shutdown()
    }
    try await configure(app)
    
    /* Incorrect register */
    try app.test(.POST, "auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name" : "",
        "last_name" : "Hui-lin",
        "birthday" : "2024-05-03T11:17:04+0800",
        "email" : "test@example.com",
        "password" : "top_secret48",
        "confirm_password" : "top_secret",
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .badRequest)
    })
    
    /* Correct register */
    try app.test(.POST, "auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name" : "Yüan",
        "last_name" : "Yüeh",
        "birthday" : "2024-05-03T11:17:04+0800",
        "email" : "test@example.com",
        "password" : "top_secret58",
        "confirm_password" : "top_secret58",
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .created)
    })
    
    /* Reach the limit */
    try app.test(.POST, "auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name" : "Ya",
        "last_name" : "Hsüan",
        "birthday" : "2024-05-03T11:17:04+0800",
        "email" : "test2@example.com",
        "password" : "top_secret42",
        "confirm_password" : "top_secret42",
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .badRequest)
    })
  }
}
