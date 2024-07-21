//
//  PageInvoker.swift
//
//
//  Created by Fang Ling on 2024/7/21.
//

import Foundation

class PageInvoker {
  /* Invoker is responsible for history, we dont need yet */
  func execute(command: Command) {
    command.execute()
  }
}
