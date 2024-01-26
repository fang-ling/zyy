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
  static let CHL_CSS_FILE = "gist-embed.css"
  
  func write_to_file() {
    do {
      /* gist-embed.css */
      try CHL_CSS.write(
        toFile: HTML.CHL_CSS_FILE,
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
      /* Blog pages should be in blog/ */
      let blog_pages = pages.filter({ $0.is_blog == 1 })
      /* Normal pages should be in / */
      let pages = pages.filter({ $0.is_blog == 0 })
      var blog_page = Page()
      blog_page.title = "Blog"
      blog_page.link = "index.html"
      blog_page.date = date2string(
        blog_pages.map({ string2date($0.date) }).sorted().last!
      )
      blog_page.content = "<table><tbody>"
      for bp in blog_pages {
        var artworks = bp.artwork.components(separatedBy: ",")
        let fallback = artworks.removeLast()
        var artwork = "<td class='image'><a href='\(bp.link)'>"
        artwork += "<picture>"
        for aw in artworks {
          artwork += "<source srcset='\(aw)' "
          artwork += "type='image/\(aw.components(separatedBy: ".").last!)'>"
        }
        artwork += "<img src='\(fallback)'></picture></a></td>"
        
        var link = "<td><a class='heading' href='\(bp.link)'>\(bp.title)</a>"
        link += "<p class='caption'>Originally published \(bp.date_created)."
        link += "<br>Last updated \(bp.date).</p></td>"
        
        blog_page.content += "<tr>\(artwork)\(link)</tr>"
      }
      blog_page.content += "</tbody></table>"
      
      if !directory_exists(at: "blog") {
        try FileManager.default.createDirectory(
          atPath: "blog", 
          withIntermediateDirectories: true
        )
      }
      
      for page in blog_pages + [blog_page] {
        try get_page(page: page).write(
          toFile: "blog/" + page.link.components(separatedBy: "/").last!,
          atomically: true,
          encoding: .utf8
        )
      }
      
      for page in pages {
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
