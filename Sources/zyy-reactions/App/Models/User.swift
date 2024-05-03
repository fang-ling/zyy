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
  var avatar : String
  
  @Field(key: "email")
  var email : String
  
  @Field(key: "password_hash")
  var password_hash : String
  
  @Field(key: "registered_at")
  var registered_at : Date
}
