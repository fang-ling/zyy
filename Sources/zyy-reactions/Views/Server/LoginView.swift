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
        link_main_style
        title {
          "Sign in to zyy"
        }
      }
      body {
        div(attributes: ["class": "page-container auth-form"]) {
          h2(attributes: ["class": "auth-form-header"]) {
            "Sign in to zyy"
          }
          div(attributes: ["class": "auth-form-body"]) {
            form(attributes: ["id": "login", "action": ""]) {
              label(attributes: ["for": "username"]) {
                "Email address"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "text",
                  "id": "username",
                  "autocomplete": "on"
                ]
              )
              label(attributes: ["for": "password"]) {
                "Password"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "password",
                  "id": "password",
                  "autocomplete": "on"
                ]
              )
              input(
                attributes: [
                  "class": "btn-primary auth-form-submit",
                  "type": "submit",
                  "value": "Sign in"
                ]
              )
            }
          }
          div(attributes: ["class": "login-callout"]) {
            p {
              "New to zyy? "
              a(attributes: ["href": "signup.html"]) {
                "Create an account"
              }
            }
          }
        }
        div(attributes: ["class": "footer auth-form-footer"]) {
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
