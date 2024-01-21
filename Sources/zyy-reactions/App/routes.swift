//
//  routes.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor

func routes(_ app : Application) throws {
  app.get("get") { req -> ReactionResponse in
    if let slug = req.query[String.self, at: "slug"] {
      let result = try db.run(
        """
        SELECT "emoji_1", "emoji_2", "emoji_3", "emoji_4" FROM "Reaction"
        WHERE ("slug" = '\(slug)');
        """
      )
      guard let row = result.first else {
        return ReactionResponse(
          emoji_1: -1,
          emoji_2: -1,
          emoji_3: -1,
          emoji_4: -1
        )
      }
      let emoji_1 = Int(row["emoji_1"]!)!
      let emoji_2 = Int(row["emoji_2"]!)!
      let emoji_3 = Int(row["emoji_3"]!)!
      let emoji_4 = Int(row["emoji_4"]!)!
      return ReactionResponse(
        emoji_1: emoji_1,
        emoji_2: emoji_2,
        emoji_3: emoji_3,
        emoji_4: emoji_4
      )
    }
    return ReactionResponse(emoji_1: -2, emoji_2: -2, emoji_3: -2, emoji_4: -2)
  }
  
  app.get("add") { req in
    if let slug = req.query[String.self, at: "slug"],
       let emoji = req.query[String.self, at: "emoji"] {
      if !["emoji_1", "emoji_2", "emoji_3", "emoji_4"].contains(emoji) {
        return "Invalid emoji"
      }
      try db.run(
        """
        UPDATE "Reaction" SET "\(emoji)" = "\(emoji)" + 1
        WHERE ("slug" = '\(slug)');
        """
      )
      return "Update slug: \(slug), at emoji: \(emoji)"
    }
    return "Invalid"
  }
}

struct ReactionResponse : Content {
  let emoji_1 : Int
  let emoji_2 : Int
  let emoji_3 : Int
  let emoji_4 : Int
}
