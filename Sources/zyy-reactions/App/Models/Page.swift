//
//  Page.swift
//
//
//  Created by Fang Ling on 2024/5/4.
//

import Fluent
import Foundation
import Vapor

final class Page : Model {
  static let schema = "Pages"
  
  @ID(key: .id)
  var id : UUID?
  
  @Field(key: "title")
  var title : String
  
  @Field(key: "content")
  var content : String
  
  @Field(key: "link")
  var link : String
  
  /* Artwork link */
  @Field(key: "artwork")
  var artwork : String
  
  @Field(key: "caption")
  var caption : String
  
  /* Author */
  @Parent(key: "user_id")
  var user : User
  
  @Timestamp(key: "created_at", on: .create)
  var created_at : Date?
  
  @Timestamp(key: "modified_at", on: .update)
  var modified_at : Date?
  
  @Field(key: "is_hidden")
  var is_hidden : Bool
  
  @Field(key: "is_blog_article")
  var is_blog_article : Bool
  
  init() { }
  
  init(
    id: UUID? = nil,
    title: String,
    content: String,
    link: String,
    artwork: String,
    caption: String,
    user_id: User.IDValue,
    created_at: Date? = nil,
    modified_at: Date? = nil,
    is_hidden: Bool,
    is_blog_article: Bool
  ) {
    self.id = id
    self.title = title
    self.content = content
    self.link = link
    self.artwork = artwork
    self.caption = caption
    self.$user.id = user_id
    self.created_at = created_at
    self.modified_at = modified_at
    self.is_hidden = is_hidden
    self.is_blog_article = is_blog_article
  }
}
