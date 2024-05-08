//
//  HTML+SharedNodes.swift
//
//
//  Created by Fang Ling on 2024/5/7.
//

import Foundation

let EN_FONT =
  "https://fonts.googleapis.com/" +
  "css?family=Gentium+Book+Basic:400,700italic,700,400italic:latin"
let CJK_FONT =
  "https://cdn.jsdelivr.net/npm/lxgw-wenkai-webfont@1.2.0/style.css"
let MAIN_STYLE = "zyy.css"

let link_en_font = link(attributes: ["rel": "stylesheet", "href": EN_FONT])
let link_cjk_font = link(attributes: ["rel": "stylesheet", "href": CJK_FONT])
let link_main_style = link(attributes: ["rel": "stylesheet","href": MAIN_STYLE])

let meta_charset = meta(attributes: ["charset": "UTF-8"])
let meta_viewport = meta(
  attributes: [
    "name": "viewport",
    "content": "width=device-width, initial-scale=1.0"
  ]
)

