//
//  Reaction.swift
//
//
//  Created by Fang Ling on 2024/4/23.
//

import Fluent
import Foundation
import Vapor

final class Reaction: Model, Content {
  static let schema = "Reactions"
  
  @ID(key: .id)
  var id: UUID?
  
  @Parent(key: "page_id")
  var page: Page
  
  @Field(key: "emoji_1")
  var emoji_1: Int
  
  @Field(key: "emoji_2")
  var emoji_2: Int
  
  @Field(key: "emoji_3")
  var emoji_3: Int
  
  @Field(key: "emoji_4")
  var emoji_4: Int
  
  init() { }
  
  init(
    id: UUID? = nil,
    page_id: Page.IDValue,
    emoji_1: Int = 0,
    emoji_2: Int = 0,
    emoji_3: Int = 0,
    emoji_4: Int = 0
  ) {
    self.id = id
    self.$page.id = page_id
    self.emoji_1 = emoji_1
    self.emoji_2 = emoji_2
    self.emoji_3 = emoji_3
    self.emoji_4 = emoji_4
  }
}

/* Fields for data exchanges */
extension Reaction {
  struct List: Content {
    var page_link: String
    var emoji_1: Int
    var emoji_2: Int
    var emoji_3: Int
    var emoji_4: Int
  }
}
