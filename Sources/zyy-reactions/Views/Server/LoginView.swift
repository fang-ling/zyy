//
//  LoginView.swift
//
//
//  Created by Fang Ling on 2024/5/7.
//

import Foundation

struct LoginView: CustomStringConvertible {
  private var document: HTMLNode
  
  init() {
    document = html(attributes: ["lang": "en"]) {
      doctype()
      head {
        meta_charset
        meta_viewport
        link_en_font
        link_cjk_font
        link_main_style
        title {
          "Sign in to zyy"
        }
      }
      body {
        div(attributes: ["class": "page-container", "style": "width: 330px;margin: 0 auto;"]) {
          h2(attributes: ["style": "text-align: center;padding-top:32px"]) {
            "Sign in to zyy"
          }
          div(attributes: ["style": "border-top: 1px solid hsla(210,18%,87%,1);border-radius: 6px;padding: 16px;font-size: 14px;background-color: #f6f8fa;border: 1px solid hsla(210,18%,87%,1);box-sizing: border-box;"]) {
            form(attributes: ["id": "login", "action": "", /* style='box-sizing: border-box;*/]) {
              label(attributes: ["for": "username", "style": "display: block;margin-bottom: 8px;"]) {
                "Email address"
              }
              input(attributes: ["style": "margin-top: 4px;margin-bottom: 16px;display: block;width: 100%;padding: 5px 12px;font-size: 14px;line-height: 20px;border-radius: 6px;border: 1px solid #d0d7de;", "required": "required", "type": "text", "id": "username", "autocomplete": "on"])
              label(attributes: ["for": "password", "style": "display: block;margin-bottom: 8px;"]) {
                "Password"
              }
              input(attributes: ["style": "margin-top: 4px;margin-bottom: 16px;display: block;width: 100%;padding: 5px 12px;font-size: 14px;line-height: 20px;border-radius: 6px;border: 1px solid #d0d7de;", "required": "required", "type": "password", "id": "password", "autocomplete": "on"])
              input(attributes: ["style": "display: block;margin-top: 16px;width: 100%;text-align: center;padding: 5px 16px;font-size: 14px;line-height: 20px;border: 1px solid var(--purple-box-color);border-radius: 6px;color: var(--purple-box-link-color);background: var(--purple-box-color);font-weight: 500;", "type": "submit", "value": "Sign in"])
            }
          }
        }
        div(attributes: ["class": "footer", "style": "margin-top: 40px"]) {
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
      }
    }
  }
  
  var description: String {
    var stream = HTMLOutputStream()
    document.render_as_HTML(into: &stream)
    return stream.flush()
  }
}
