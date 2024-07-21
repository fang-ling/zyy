//
//  build.swift
//
//
//  Created by Fang Ling on 2023/5/26.
//

import ArgumentParser
import Foundation

extension zyy {
  struct Build : ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Build static files."
    )
    
    func run() {
      let db = DatabaseDriver()
      
      /* Update build count */
      let count = Int(
        db.get_setting(with: ZYY_SET_OPT_BUILD_COUNT)!,
        radix: 16
      )!
      db.set_setting(
        with: ZYY_SET_OPT_BUILD_COUNT,
        new: String(count + 1, radix: 16)
      )
      /* Grab all of the data */
      let pages = db.get_pages().filter({ $0.is_hidden == 0 })
      let sections = db.get_sections()
      var settings = [String : String]()
      settings[ZYY_SET_OPT_BUILD_COUNT] =
        db.get_setting(with: ZYY_SET_OPT_BUILD_COUNT)
      settings[ZYY_SET_OPT_INDEX_UPDATE_TIME] =
        db.get_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME)
      settings[ZYY_SET_OPT_TITLE] =
        db.get_setting(with: ZYY_SET_OPT_TITLE)
      settings[ZYY_SET_OPT_URL] =
        db.get_setting(with: ZYY_SET_OPT_URL)
      settings[ZYY_SET_OPT_AUTHOR] =
        db.get_setting(with: ZYY_SET_OPT_AUTHOR)
      settings[ZYY_SET_OPT_START_YEAR] =
        db.get_setting(with: ZYY_SET_OPT_START_YEAR)
      settings[ZYY_SET_OPT_CUSTOM_HEAD] =
        db.get_setting(with: ZYY_SET_OPT_CUSTOM_HEAD)
      settings[ZYY_SET_OPT_CUSTOM_MD] =
        db.get_setting(with: ZYY_SET_OPT_CUSTOM_MD)
      for field in ZYY_SET_OPT_CUSTOM_FIELDS {
        settings[field] = db.get_setting(with: field)
      }
      for url in ZYY_SET_OPT_CUSTOM_FIELD_URLS {
        settings[url] = db.get_setting(with: url)
      }
      
      HTML(
        pages: pages,
        sections: sections,
        settings: settings
      ).write_to_file()
    }
  }
}
