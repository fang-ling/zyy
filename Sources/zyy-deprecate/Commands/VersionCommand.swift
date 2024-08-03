//
//  VersionCommand.swift
//
//
//  Created by Fang Ling on 2024/5/7.
//

import Vapor

struct VersionCommand: AsyncCommand {
  struct Signature: CommandSignature { }
  
  var help: String = "Print version information"
  
  func run(using context: CommandContext, signature: Signature) async throws {
    context.console.print(VERSION)
  }
}
