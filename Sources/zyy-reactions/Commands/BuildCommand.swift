//
//  BuildCommand.swift
//
//
//  Created by Fang Ling on 2024/5/8.
//

import Foundation
import Vapor

struct BuildCommand: AsyncCommand {
  struct Signature: CommandSignature {
    @Argument(name: "path")
    var path: String
  }
  
  var help: String = "Build zyy server front-end"
  
  func run(using context: CommandContext, signature: Signature) async throws {
    let main_style_url = Bundle.module.url(forResource: "zyy", withExtension: "css")!
    
    try String(contentsOf: main_style_url).write(toFile: signature.path + "/zyy.css", atomically: true, encoding: .utf8)
    
    try LoginView().description.write(toFile: signature.path + "/login.html", atomically: true, encoding: .utf8)
  }
}
