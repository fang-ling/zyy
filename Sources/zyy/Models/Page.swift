//
//  Page.swift
//
//
//  Created by Fang Ling on 2024/7/21.
//

import Foundation
import SwiftData

@Model
final class Page {
  @Attribute(.unique) var title: String
  var content: String
  var link: String
  var date: Date
  var is_hidden: Bool
  var is_blog: Bool
  var created_at: Date
  var artworkLink: String /* Do not need base64 */
  
  init(_ pageDTO: PageDTO) {
    title = pageDTO.title
    content = pageDTO.content
    link = pageDTO.link
    date = pageDTO.date
    is_hidden = pageDTO.isHidden
    is_blog = pageDTO.isBlog
    created_at = pageDTO.createdAt
    artworkLink = pageDTO.artworkLink
  }
}

struct PageDTO {
  let title: String
  let content: String
  let link: String
  let date: Date
  let isHidden: Bool
  let isBlog: Bool
  let createdAt: Date
  let artworkLink: String
}
