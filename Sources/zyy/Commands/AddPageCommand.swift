//
//  AddPageCommand.swift
//
//
//  Created by Fang Ling on 2024/7/21.
//

import Foundation

class AddPageCommand: Command {
  private var page: PageReceiver
  private var pageModel: PageModel
  
  init(page: PageReceiver, pageModel: PageModel) {
    self.page = page
    self.pageModel = pageModel
  }
  
  func execute() {
    page.add(pageModel: pageModel)
  }
}
