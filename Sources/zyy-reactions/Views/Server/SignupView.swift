//
//  SignupView.swift
//  
//
//  Created by Fang Ling on 2024/5/9.
//

import Foundation

struct SignupView: CustomStringConvertible {
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
          "Join zyy"
        }
      }
      body {
        div(attributes: ["class": "page-container auth-form"]) {
          h2(attributes: ["class": "auth-form-header"]) {
            "Create Your zyy Account"
          }
          div(attributes: ["class": "auth-form-body"]) {
            form(attributes: ["id": "login", "action": ""]) {
              label(attributes: ["for": "first-name"]) {
                "First name"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "text",
                  "id": "first-name"
                ]
              )
              label(attributes: ["for": "last-name"]) {
                "Last name"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "text",
                  "id": "last-name"
                ]
              )
              label(attributes: ["for": "birthday"]) {
                "Birthday"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "date",
                  "id": "birthday"
                ]
              )
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
              label(attributes: ["for": "confirm-password"]) {
                "Confirm Password"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "password",
                  "id": "confirm-password",
                  "autocomplete": "on"
                ]
              )
              label(attributes: ["for": "website"]) {
                "Website"
              }
              input(
                attributes: [
                  "class": "auth-form-input-block",
                  "required": "required",
                  "type": "text",
                  "id": "website",
                  "value": "https://"
                ]
              )
              input(
                attributes: [
                  "class": "btn-primary auth-form-submit",
                  "type": "submit",
                  "value": "Sign up"
                ]
              )
            }
          }
          div(attributes: ["class": "login-callout"]) {
            p {
              "Already have an account? "
              a(attributes: ["href": "login.html"]) {
                "Sign in →"
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

