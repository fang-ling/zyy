//
//  HTMLOutputStream.swift
//
//
//  Created by Fang Ling on 2024/5/7.
//

import Foundation

struct HTMLOutputStream {
  var buffer: String = ""
  
  static let unsafe_characters: Set<Character> = [
    "\t", /* 9  tab */
    "\n", /* 10 newline */
    " ",  /* 32 nbsp */
    "\"", /* 34 quot */
    "&",  /* 38 amp */
    "'",  /* 39 apos */
    "<",  /* 60 lt */
    ">",  /* 62 gt */
  ]
  
  mutating func write(_ content: String) {
    buffer += content
  }
  
  mutating func write_double_quoted(_ content: String) {
    buffer += "\"\(content)\""
  }
  
  mutating func write_escaped(_ content: String) {
    for character in content {
      if HTMLOutputStream.unsafe_characters.contains(character) {
        /* One of the required escapes for security reasons */
        buffer += "&#\(character.asciiValue!);"
      } else {
        /* Not a required escape, no need to replace the character */
        buffer.append(character)
      }
    }
  }
  
  mutating func flush() -> String {
    let result = buffer
    buffer = ""
    return result
  }
}
