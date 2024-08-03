//
//  PageController.swift
//
//
//  Created by Fang Ling on 2024/7/21.
//

import Foundation
import SwiftData

@MainActor
class PageController {
  /// The shared page controller object for the process.
  static var `default` = PageController()
  
  var modelContext: ModelContext
  
  private init() {
    let modelConfiguration = ModelConfiguration(url: ZYY_DATABASE_URL)
    do {
      let modelContainer = try ModelContainer(
        for: Page.self,
        configurations: modelConfiguration
      )
      modelContext = modelContainer.mainContext
    } catch {
      fatalError(error.localizedDescription)
    }
  }
}
