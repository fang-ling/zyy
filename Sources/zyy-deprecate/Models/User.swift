//
//  User.swift
//  
//
//  Created by Fang Ling on 2024/5/2.
//

import Fluent
import Foundation
import Vapor

final class User: Model {
  static let schema = "Users"
  
  @ID(key: .id)
  var id: UUID?
  
  @Field(key: "first_name")
  var first_name: String
  
  @Field(key: "last_name")
  var last_name: String
  
  @Field(key: "birthday")
  var birthday: Date
  
  @Field(key: "avatar")
  var avatar: String?
  
  @Field(key: "email")
  var email: String
  
  @Field(key: "password_hash")
  var password_hash: String
  
  @Timestamp(key: "registered_at", on: .create)
  var registered_at: Date?
  
  /* The user website URL */
  @Field(key: "link")
  var link: String
  
  init() { }
  
  init(
    id: UUID? = nil,
    first_name: String,
    last_name: String,
    birthday: Date,
    avatar: String? = nil,
    email: String,
    password_hash: String,
    registered_at: Date? = nil,
    link: String
  ) {
    self.id = id
    self.first_name = first_name
    self.last_name = last_name
    self.birthday = birthday
    self.avatar = avatar
    self.email = email
    self.password_hash = password_hash
    self.registered_at = registered_at
    self.link = link
  }
}

extension User: ModelAuthenticatable {
  static let usernameKey = \User.$email
  static let passwordHashKey = \User.$password_hash
  
  func verify(password: String) throws -> Bool {
    try Bcrypt.verify(password, created: self.password_hash)
  }
}

extension User {
  func generate_token() throws -> UserToken {
    try UserToken(
      value: [UInt8].random(count: 32).base64,
      expires_at: Date() + TOKEN_EXPIRATION_MINUTES * 60,
      user_id: self.requireID()
    )
  }
}

/* Fields for data exchanges */
extension User {
  struct Registration: Content, Validatable {
    var first_name: String
    var last_name: String
    var birthday: Date
    var email: String
    var password: String
    var confirm_password: String
    var link: String
    
    static func validations(_ validations: inout Validations) {
      validations.add("first_name", as: String.self, is: !.empty)
      validations.add("last_name", as: String.self, is: !.empty)
      validations.add("email", as: String.self, is: .email)
      validations.add("password", as: String.self, is: .count(8...))
      validations.add("link", as: String.self, is: !.empty)
    }
  }
  
  struct Me: Content {
    var first_name: String
    var last_name: String
    var link: String
  }
}
