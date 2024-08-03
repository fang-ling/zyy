//
//  PageController+Creation.swift
//
//
//  Created by Fang Ling on 2024/8/3.
//

import Foundation
import SwiftData /* Test */

extension PageController {
  func create(pageDTO: PageDTO) {
    modelContext.insert(Page(pageDTO))
    
    do {
      try modelContext.save()
    } catch {
      print(error)
    }
    
    /* Test */
    let fetchDescriptor = FetchDescriptor<Page>()
    do {
      print(try modelContext.fetch(fetchDescriptor).map({ "\($0.title) \($0.date)\n" }))
    } catch {
      print(error)
    }
  }
}
