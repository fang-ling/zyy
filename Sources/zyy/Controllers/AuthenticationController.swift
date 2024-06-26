//
//  AuthenticationController.swift
//
//
//  Created by Fang Ling on 2024/5/3.
//

import Foundation
import Vapor
import Fluent

/*
 * +--------+--------------------+--------+-----------------------------------+
 * | Method |        Routes      | Authen |            Description            |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   201: Registration successful    |
 * | POST   | /api/auth/register | None   | Error:                            |
 * |        |                    |        |   400: Invalid registration form  |
 * |        |                    |        |   400: Registration limit reached |
 * +--------+--------------------+--------+-----------------------------------+
 * |        |                    |        | Success:                          |
 * |        |                    |        |   200: Return user token          |
 * | POST   | /api/auth/login    | Basic  | Error:                            |
 * |        |                    |        |   401: Invalid credentials        |
 * +--------+--------------------+--------+-----------------------------------+
 *
 * TODO: PASSWORD MODIFICATION
 *
 */
struct AuthenticationController: RouteCollection {
  func boot(routes: RoutesBuilder) throws {
    routes.group("api") { api in
      api.group("auth") { auth in
        auth.post("register", use: register_handler)
        auth.grouped(User.authenticator()).post("login", use: login_handler)
      }
    }
  }
  
  /* Returns HTTP 201 created when success */
  func register_handler(req: Request) async throws -> HTTPStatus {
    if try await User.query(on: req.db).all().count >= USER_REGISTRATION_LIMIT {
      throw Abort(.badRequest, reason: "User Registration Limit Reached")
    }
    
    try User.Registration.validate(content: req)
    let registration = try req.content.decode(User.Registration.self)
    guard registration.password == registration.confirm_password else {
      throw Abort(.badRequest, reason: "Passwords did not match")
    }
    let user = try User(
      first_name: registration.first_name,
      last_name: registration.last_name,
      birthday: registration.birthday,
      email: registration.email,
      password_hash: Bcrypt.hash(registration.password),
      link: registration.link
    )
    try await user.save(on: req.db)
    return .created
  }
  
  /* Basic auth */
  func login_handler(req: Request) async throws -> UserToken {
    let user = try req.auth.require(User.self)
    let token = try user.generate_token()
    
    try await token.save(on: req.db)
    
    return token
  }
}
