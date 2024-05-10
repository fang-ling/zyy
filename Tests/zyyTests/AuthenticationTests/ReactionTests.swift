//
//  ReactionTests.swift
//
//
//  Created by Fang Ling on 2024/5/5.
//

@testable import zyy
import Foundation
import Fluent
import XCTVapor

final class ReactionTests: XCTestCase {
  func test_reaction() async throws {
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
    
    /* Login */
    var user_token = UserToken()
    try app.test(.POST, "api/auth/login", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Basic " + "test@example.com:top_secret58".base64String()
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      user_token = try res.content.decode(UserToken.self)
    })
    
    /* Correct create page */
    try app.test(.POST, "api/page", beforeRequest: { req in
      req.headers.add(
        name: "Authorization", 
        value: "Bearer \(user_token.value)"
      )
      let page = Page.Create(
        title: "Hello, world!",
        content: "This is a test article.",
        link: "hello-world.html",
        artwork: "hello-world.jxl,hello-world.webp",
        caption: "This is a test article.",
        is_hidden: false,
        is_blog_article: true
      )
      try req.content.encode(page)
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .created)
    })
    
    /* Read page list (to get id) */
    var id = UUID()
    try app.test(.GET, "api/pages", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \(user_token.value)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      id = try res.content.decode([zyy.Page.List].self).first!.id
    })
    
    /* Invalid create reaction */
    try app.test(.POST, "api/reaction", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \(user_token.value)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .badRequest)
    })
    
    /* Invalid token */
    try app.test(.POST, "api/reaction?id=\(id)", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \([UInt8].random(count: 32).base64)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .unauthorized)
    })
    
    /* No such id */
    try app.test(.POST, "api/reaction?id=\(UUID())", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \(user_token.value)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .badRequest)
    })
    
    /* Author mismatch test case skipped */
    
    /* Correct create reaction */
    try app.test(.POST, "api/reaction?id=\(id)", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \(user_token.value)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .created)
    })
    
    /* Duplicate create reaction */
    try app.test(.POST, "api/reaction?id=\(id)", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \(user_token.value)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .conflict)
    })
    
    /* Get test, invalid query */
    try app.test(.GET, "api/reaction") { res in
      XCTAssertEqual(res.status, .badRequest)
    }
    
    /* Get test, invalid id */
    try app.test(.GET, "api/reaction?id=\(UUID())") { res in
      XCTAssertEqual(res.status, .badRequest)
    }
    
    /* Get test, success */
    try app.test(.GET, "api/reaction?id=\(id)") { res in
      XCTAssertEqual(res.status, .ok)
      let reaction = try res.content.decode(Reaction.self)
      XCTAssertEqual(reaction.emoji_1, 0)
      XCTAssertEqual(reaction.emoji_2, 0)
      XCTAssertEqual(reaction.emoji_3, 0)
      XCTAssertEqual(reaction.emoji_4, 0)
    }
    
    /* Update test, invalid query */
    try app.test(.PATCH, "api/reaction") { res in
      XCTAssertEqual(res.status, .badRequest)
    }
    
    /* Update test, invalid id */
    try app.test(.PATCH, "api/reaction?id=\(UUID())&emoji=1") { res in
      XCTAssertEqual(res.status, .badRequest)
    }
    
    /* Update test, invalid emoji */
    try app.test(.PATCH, "api/reaction?id=\(id)&emoji=6") { res in
      XCTAssertEqual(res.status, .badRequest)
    }
    
    /* Update test, success */
    try app.test(.PATCH, "api/reaction?id=\(id)&emoji=1") { res in
      XCTAssertEqual(res.status, .ok)
    }
    try app.test(.PATCH, "api/reaction?id=\(id)&emoji=2") { res in
      XCTAssertEqual(res.status, .ok)
    }
    try app.test(.PATCH, "api/reaction?id=\(id)&emoji=3") { res in
      XCTAssertEqual(res.status, .ok)
    }
    try app.test(.PATCH, "api/reaction?id=\(id)&emoji=4") { res in
      XCTAssertEqual(res.status, .ok)
    }
    try app.test(.GET, "api/reaction?id=\(id)") { res in
      XCTAssertEqual(res.status, .ok)
      let reaction = try res.content.decode(Reaction.self)
      XCTAssertEqual(reaction.emoji_1, 1)
      XCTAssertEqual(reaction.emoji_2, 1)
      XCTAssertEqual(reaction.emoji_3, 1)
      XCTAssertEqual(reaction.emoji_4, 1)
    }
   
    /* Test case for read reactions */
    try app.test(.GET, "api/reactions") { res in
      XCTAssertEqual(res.status, .unauthorized)
    }
    
    try app.test(.GET, "api/reactions", beforeRequest: { req in
      req.headers.add(
        name: "Authorization",
        value: "Bearer \(user_token.value)"
      )
    }, afterResponse: { res in
      XCTAssertEqual(res.status, .ok)
      let reactions = try res.content.decode([Reaction.List].self)
      XCTAssertEqual(reactions.count, 1)
      XCTAssertEqual(reactions.first!.page_link, "hello-world.html")
      XCTAssertEqual(reactions.first!.emoji_1, 1)
      XCTAssertEqual(reactions.first!.emoji_2, 1)
      XCTAssertEqual(reactions.first!.emoji_3, 1)
      XCTAssertEqual(reactions.first!.emoji_4, 1)
    })
  }
}
