//
//  main.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor
import CSQLite

let db = try SQLite("zyy.db")

if CommandLine.argc > 1 && CommandLine.arguments[1] == "init" {
  try db.run(
    """
    CREATE TABLE IF NOT EXISTS "Reaction" (
      "slug" TEXT PRIMARY KEY,
      "emoji_1" INTEGER DEFAULT 0,
      "emoji_2" INTEGER DEFAULT 0,
      "emoji_3" INTEGER DEFAULT 0,
      "emoji_4" INTEGER DEFAULT 0
    );
    """
  )
  exit(0)
}

if CommandLine.argc > 2 && CommandLine.arguments[1] == "new" {
  try db.run(
    """
    INSERT INTO "Reaction" ("slug") VALUES ('\(CommandLine.arguments[2])');
    """
  )
  exit(0)
}

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer {
  app.shutdown()
}
try configure(app)
try app.run()
