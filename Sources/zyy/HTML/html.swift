//
//  html.swift
//
//
//  Created by Fang Ling on 2023/5/26.
//

import Foundation

struct HTML {
  var pages : [Page]
  var sections : [Section]
  var settings : [String : String]
  
  static let FONT_LINK =
  "https://fonts.googleapis.com/css?family=" +
  "Gentium+Book+Basic:400,700italic,700,400italic:latin"
  static let FONT_TC_LINK =
  "https://cdn.jsdelivr.net/npm/lxgw-wenkai-tc-webfont@1.2.0/style.css"
  static let MAIN_STYLE_CSS_FILENAME = "style.css"
  static let CHL_CSS_FILENAME = "gist-embed.css"
  
  func write_to_file() {
    do {
      /* gist-embed.css */
      try CHL_CSS.write(
        toFile: HTML.CHL_CSS_FILENAME,
        atomically: true,
        encoding: .utf8
      )
      /* style.css */
      try MAIN_STYLE_CSS.write(
        toFile: HTML.MAIN_STYLE_CSS_FILENAME,
        atomically: true,
        encoding: .utf8
      )
      let index_t = settings[ZYY_SET_OPT_INDEX_UPDATE_TIME]!
      /* index.html */
      try get_index(date: index_t).write(toFile: "index.html",
                                         atomically: true,
                                         encoding: .utf8)
      var blog_page = Page()
      blog_page.title = "Blog"
      blog_page.link = "blog.html"
      blog_page.date = get_current_date_string()
      blog_page.content = pages
        .filter({ $0.is_blog == 1 })
        .map({ "[_\($0.date_created)_] [\($0.title)](\($0.link))" })
        .joined(separator: "<br>")
      
      // TO-DO: add file hierarch
      for page in pages + [blog_page] {
        try get_page(page: page).write(
          toFile: page.link.components(separatedBy: "/").last!,
          atomically: true,
          encoding: .utf8
        )
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func get_all_headbox_custom_fields() -> [(String, String)] {
    var res = [(String, String)]()
    for i in 0 ..< ZYY_SET_OPT_CUSTOM_FIELDS.count {
      let tuple = (
        settings[ZYY_SET_OPT_CUSTOM_FIELDS[i]]!,
        settings[ZYY_SET_OPT_CUSTOM_FIELD_URLS[i]]!
      )
      if !tuple.0.isEmpty {
        res.append(tuple)
      }
    }
    return res
  }
}
