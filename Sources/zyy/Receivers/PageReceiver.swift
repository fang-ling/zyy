//
//  PageReceiver.swift
//
//
//  Created by Fang Ling on 2024/7/21.
//

import Foundation

class PageReceiver {
//  private var model: Page
  
//  init(model: Page) {
//    self.model = model
//  }
  
  func add(pageModel: PageModel) {
    /* Do db add in here */
    print("From Receiver: add page \(pageModel.title) in database")
  }
}
