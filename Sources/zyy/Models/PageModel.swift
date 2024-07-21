//
//  PageModel.swift
//
//
//  Created by Fang Ling on 2024/7/21.
//

import Foundation

struct PageModel: Equatable {
  var id: Int
  var title: String
  var content: String
  var link: String
  var date: String
  var is_hidden: Int
  var is_blog: Int
  var date_created: String
  var artwork: String /* Do not need base64 */
  
  init() {
    id = 0
    title = ""
    content = ""
    link = ""
    date = ""
    is_hidden = 0
    is_blog = 0
    date_created = ""
    artwork = ""
  }
}
