//
//  UserToken.swift
//
//
//  Created by Fang Ling on 2024/5/4.
//

import Foundation
import Fluent
import Vapor

final class UserToken : Model, Content {
  static let schema = "UserTokens"
  
  @ID(key: .id)
  var id : UUID?
  
  @Field(key: "value")
  var value : String
  
  @Field(key: "expires_at")
  var expires_at : Date
  
  @Parent(key: "user_id")
  var user : User
  
  init() { }
  
  init(
    id: UUID? = nil,
    value: String,
    expires_at: Date,
    user_id: User.IDValue
  ) {
    self.id = id
    self.value = value
    self.expires_at = expires_at
    self.$user.id = user_id
  }
}

extension UserToken : ModelTokenAuthenticatable {
  static let valueKey = \UserToken.$value
  static let userKey = \UserToken.$user
  
  var isValid : Bool {
    Date() <= expires_at
  }
}
