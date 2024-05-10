//
//  HTML+Node.swift
//
//
//  Created by Fang Ling on 2024/5/7.
//

import Foundation

struct HTMLNode: HTML {
  var tag: String
  var attributes: [String: String] = [:]
  var children: [HTML] = []

  func render_as_HTML(into stream: inout HTMLOutputStream) {
    stream.write("<")
    stream.write(tag)
    for (k, v) in attributes.sorted(by: { $0.0 < $1.0 }) {
      stream.write(" ")
      stream.write(k)
      stream.write("=")
      stream.write_double_quoted(v)
    }
    if children.isEmpty {
      stream.write("/>")
    } else {
      stream.write(">")
      for child in children {
        child.render_as_HTML(into: &stream)
      }
      stream.write("</")
      stream.write(tag)
      stream.write(">")
    }
  }
}

struct HTMLNodeWithoutChildren: HTML {
  var tag: String
  var attributes: [String: String] = [:]
  
  func render_as_HTML(into stream: inout HTMLOutputStream) {
    stream.write("<")
    stream.write(tag)
    for (k, v) in attributes.sorted(by: { $0.0 < $1.0 }) {
      stream.write(" ")
      stream.write(k)
      stream.write("=")
      stream.write_double_quoted(v)
    }
    stream.write(">")
  }
}

struct script: HTML {
  var tag: String = "script"
  var attributes: [String: String] = [:]
  var content: String

  func render_as_HTML(into stream: inout HTMLOutputStream) {
    stream.write("<")
    stream.write(tag)
    for (k, v) in attributes.sorted(by: { $0.0 < $1.0 }) {
      stream.write(" ")
      stream.write(k)
      stream.write("=")
      stream.write_double_quoted(v)
    }
    stream.write(">")
    stream.write(content)
    stream.write("</")
    stream.write(tag)
    stream.write(">")
  }
  
  init(attributes: [String: String] = [:], _ content: String = "") {
    self.attributes = attributes
    self.content = content
  }
}

extension String: HTML {
  func render_as_HTML(into stream: inout HTMLOutputStream) {
    stream.write_escaped(self)
  }
}

struct unsafe_raw_html: HTML {
  var html: String
  
  init(_ html: String) {
    self.html = html
  }
  
  func render_as_HTML(into stream: inout HTMLOutputStream) {
    stream.write(html)
  }
}

struct doctype: HTML {
  func render_as_HTML(into stream: inout HTMLOutputStream) {
    stream.write("<!DOCTYPE html>")
  }
}

func a(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "a", attributes: attributes, children: makeChildren())
}

func body(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "body", attributes: attributes, children: makeChildren())
}

func br(attributes: [String: String] = [:]) -> HTMLNodeWithoutChildren {
  return HTMLNodeWithoutChildren(tag: "br", attributes: attributes)
}

func div(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "div", attributes: attributes, children: makeChildren())
}

func form(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "form", attributes: attributes, children: makeChildren())
}

func h1(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "h1", attributes: attributes, children: makeChildren())
}

func h2(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "h2", attributes: attributes, children: makeChildren())
}

func head(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "head", attributes: attributes, children: makeChildren())
}

func html(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "html", attributes: attributes, children: makeChildren())
}

func input(attributes: [String: String] = [:]) -> HTMLNodeWithoutChildren {
  return HTMLNodeWithoutChildren(tag: "input", attributes: attributes)
}

func label(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(
    tag: "label",
    attributes: attributes,
    children: makeChildren()
  )
}

func link(attributes: [String: String] = [:]) -> HTMLNodeWithoutChildren {
  return HTMLNodeWithoutChildren(tag: "link", attributes: attributes)
}

func meta(attributes: [String: String] = [:]) -> HTMLNodeWithoutChildren {
  return HTMLNodeWithoutChildren(tag: "meta", attributes: attributes)
}

func p(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "p", attributes: attributes, children: makeChildren())
}

func span(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(tag: "span", attributes: attributes, children: makeChildren())
}

func strong(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(
    tag: "strong",
    attributes: attributes,
    children: makeChildren()
  )
}

func title(
  attributes: [String: String] = [:],
  @HTMLBuilder makeChildren: () -> [HTML]
) -> HTMLNode {
  return HTMLNode(
    tag: "title",
    attributes: attributes,
    children: makeChildren()
  )
}
//var a = html {
////  head {
////  }
//  body {
//    p {
//      "test"
//    }
//    p(attributes: ["color": "white"]) {
//      "test"
//    }
//    
//    if 1 == 1 {
//      p {
//        "test2"
//      }
//    }
//    
//    if 1 == 1 {
//      p {
//        """
//        hello<>    test,
//        world
//        """
//      }
//    }
//    unsafe_raw_html("<p>unsafe</p>")
//  }
//}


//a.renderAsHTML(into: HTMLOutputStream())
//print(buffer)

