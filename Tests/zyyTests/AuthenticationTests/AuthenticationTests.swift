//
//  AuthenticationTests.swift.
//
//
//  Created by Fang Ling on 2024/5/3.
//

@testable import zyy
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
    try app.test(.POST, "api/auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name": "",
        "last_name": "Hui-lin",
        "birthday": "2024-05-03T11:17:04+0800",
        "email": "test@example.com",
        "password": "top_secret48",
        "confirm_password": "top_secret",
        "link": "https://example.com/about"
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .badRequest)
    })
    
    /* Correct register */
    try app.test(.POST, "api/auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name": "Yüan",
        "last_name": "Yüeh",
        "birthday": "2024-05-03T11:17:04+0800",
        "email": "test@example.com",
        "password": "top_secret58",
        "confirm_password": "top_secret58",
        "link": "https://example.com/about"
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .created)
    })
    
    /* Reach the limit */
    try app.test(.POST, "api/auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name": "Ya",
        "last_name": "Hsüan",
        "birthday": "2024-05-03T11:17:04+0800",
        "email": "test2@example.com",
        "password": "top_secret42",
        "confirm_password": "top_secret42",
        "link": "https://example.com/about"
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .badRequest)
    })
  }
  
  func test_login() async throws {
    let app = Application(.testing)
    defer {
      app.shutdown()
    }
    try await configure(app)
    
    /* Correct register */
    try app.test(.POST, "api/auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name": "Yüan",
        "last_name": "Yüeh",
        "birthday": "2024-05-03T11:17:04+0800",
        "email": "test@example.com",
        "password": "top_secret58",
        "confirm_password": "top_secret58",
        "link": "https://example.com/about"
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .created)
    })
    
    /* No such user */
    try app.test(.POST, "api/auth/login", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Basic " + "test3@example.com:top_secret58".base64String()
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .unauthorized)
    })
    
    /* Wrong password */
    try app.test(.POST, "api/auth/login", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Basic " + "test@example.com:top_secret59".base64String()
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .unauthorized)
    })
    
    /* Correct login */
    try app.test(.POST, "api/auth/login", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Basic " + "test@example.com:top_secret58".base64String()
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      let _ = try res.content.decode(UserToken.self)
    })
  }
}
