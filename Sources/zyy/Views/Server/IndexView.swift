//
//  IndexView.swift
//
//
//  Created by Fang Ling on 2024/5/10.
//

import Foundation

struct IndexView: CustomStringConvertible {
  private var document: HTMLNode
  
  init() {
    document = html(attributes: ["lang": "en"]) {
      doctype()
      head {
        meta_charset
        meta_viewport
        link_en_font
        link_main_style
        title {
          "Home"
        }
      }
      body {
        h1(attributes: ["class": "title-text"]) {
          strong {
            "Home"
          }
        }
        div(attributes: ["class": "purplebox head-box"]) {
          a(attributes: ["class": "zyy-menu-overview", "href": ""]) {
            "Overview"
          }
          span_purplebox_separator
          a(attributes: ["class": "zyy-menu-placeholder", "href": ""]) {
            "Placeholder"
          }
        }
        div(attributes: ["class": "page-container"]) {
          
        }
        div(attributes: ["class": "purplebox foot-box"]) {
          i(attributes: ["id": "dashboard-me"]) {
            "Placeholder"
          }
        }
        div(attributes: ["class": "footer"]) {
          p {
            "Made with ♡"
            a(attributes: ["href": "https://fangl.ing"]) {
              "by Fang Ling"
            }
            a(attributes: ["href": GITHUB_LINK]) {
              "zyy v\(VERSION)"
            }
          }
          p {
            "© 2022-\(Calendar.current.component(.year,from: Date())) Fang Ling"
          }
        }
        script_main_js
        script(
          "dashboard_me();"
        )
      }
    }
  }
  
  var description: String {
    var stream = HTMLOutputStream()
    document.render_as_HTML(into: &stream)
    return stream.flush()
  }
}
