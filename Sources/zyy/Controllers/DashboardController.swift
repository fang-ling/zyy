//
//  DashboardController.swift
//
//
//  Created by Fang Ling on 2024/5/10.
//

import Foundation
import Vapor
import Fluent

/*
 * +--------+--------------------+--------+-----------------------------------+
 * | Method |        Routes      | Authen |            Description            |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   200: Return User.Me             |
 * | GET    | /me                | Bearer | Error:                            |
 * |        |                    |        |   401: Unauthorized               |
 * +--------+--------------------+--------+-----------------------------------+
 */

struct DashboardController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.group("me") { me in
      me.grouped(UserToken.authenticator()).get(use: me_handler)
    }
  }
  
  func me_handler(req: Request) async throws -> User.Me {
    let user = try req.auth.require(User.self)
    
    return User.Me(
      first_name: user.first_name,
      last_name: user.last_name,
      link: user.link
    )
  }
}
