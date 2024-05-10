//
//  DashboardTests.swift
//
//
//  Created by Fang Ling on 2024/5/10.
//

@testable import zyy
import Foundation
import Fluent
import XCTVapor

final class DashboardTests: XCTestCase {
  func test_me() async throws {
    let app = Application(.testing)
    defer {
      app.shutdown()
    }
    try await configure(app)
    
    /* Correct register */
    try app.test(.POST, "auth/register", beforeRequest: { req in
      try req.content.encode([
        "first_name" : "Yüan",
        "last_name" : "Yüeh",
        "birthday" : "2024-05-03T11:17:04+0800",
        "email" : "test@example.com",
        "password" : "top_secret58",
        "confirm_password" : "top_secret58",
        "link" : "https://example.com/about"
      ])
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .created)
    })
    
    /* Invalid user */
    try app.test(.GET, "me", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer " + "test@example.com:top_secret58".base64String()
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .unauthorized)
    })
    
    /* Correct login */
    var user_token = UserToken()
    try app.test(.POST, "auth/login", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Basic " + "test@example.com:top_secret58".base64String()
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      user_token = try res.content.decode(UserToken.self)
    })
    
    /* Correct get me */
    try app.test(.GET, "me", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer " + user_token.value
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      let me = try res.content.decode(User.Me.self)
      XCTAssertEqual(me.link, "https://example.com/about")
      XCTAssertEqual(me.first_name, "Yüan")
      XCTAssertEqual(me.last_name, "Yüeh")
    })
  }
}
