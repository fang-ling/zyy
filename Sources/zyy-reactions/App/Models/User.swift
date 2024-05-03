//
//  User.swift
//  
//
//  Created by Fang Ling on 2024/5/2.
//

import Fluent
import Foundation
import Vapor

final class User : Model {
  static let schema = "Users"
  
  @ID(key: .id)
  var id : UUID?
  
  @Field(key: "first_name")
  var first_name : String
  
  @Field(key: "last_name")
  var last_name : String
  
  @Field(key: "birthday")
  var birthday : Date
  
  @Field(key: "avatar")
  var avatar : String?
  
  @Field(key: "email")
  var email : String
  
  @Field(key: "password_hash")
  var password_hash : String
  
  @Field(key: "registered_at")
  var registered_at : Date
  
  init() { }
  
  init(
    id: UUID? = nil,
    first_name: String,
    last_name: String,
    birthday: Date,
    avatar: String? = nil,
    email: String,
    password_hash: String,
    registered_at: Date
  ) {
    self.id = id
    self.first_name = first_name
    self.last_name = last_name
    self.birthday = birthday
    self.avatar = avatar
    self.email = email
    self.password_hash = password_hash
    self.registered_at = registered_at
  }
}

extension User {
  struct Registration : Content, Validatable {
    var first_name : String
    var last_name : String
    var birthday : Date
    var email : String
    var password : String
    var confirm_password : String
    
    static func validations(_ validations: inout Validations) {
      validations.add("first_name", as: String.self, is: !.empty)
      validations.add("last_name", as: String.self, is: !.empty)
      validations.add("email", as: String.self, is: .email)
      validations.add("password", as: String.self, is: .count(8...))
    }
  }
}
