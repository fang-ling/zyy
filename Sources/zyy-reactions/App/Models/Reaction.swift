//
//  Reaction.swift
//
//
//  Created by Fang Ling on 2024/4/23.
//

import Fluent
import Foundation
import Vapor

final class Reaction : Model, Content {
  static let schema = "Reactions"
  
  @ID(key: .id)
  var id : UUID?
  
  @Field(key: "slug")
  var slug : String
  
  @Field(key: "emoji_1")
  var emoji_1 : Int
  
  @Field(key: "emoji_2")
  var emoji_2 : Int
  
  @Field(key: "emoji_3")
  var emoji_3 : Int
  
  @Field(key: "emoji_4")
  var emoji_4 : Int
  
  init() { }
  
  init(
    id: UUID? = nil,
    slug: String,
    emoji_1: Int,
    emoji_2: Int,
    emoji_3: Int,
    emoji_4: Int
  ) {
    self.id = id
    self.slug = slug
    self.emoji_1 = emoji_1
    self.emoji_2 = emoji_2
    self.emoji_3 = emoji_3
    self.emoji_4 = emoji_4
  }
}
