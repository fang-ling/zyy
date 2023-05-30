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
    static let MAIN_STYLE_CSS_FILENAME = "style.css"
    static let CHL_CSS_FILENAME = "gist-embed.css"
}
