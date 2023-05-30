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
            /* Update build count */
            let count = Int(get_setting(with: ZYY_SET_OPT_BUILD_COUNT)!,
                            radix: 16)!
            set_setting(with: ZYY_SET_OPT_BUILD_COUNT,
                        new_value: String(count + 1, radix: 16))
            /* Grab all of the data */
            let pages = get_pages()
            let sections = get_sections()
            var settings = [String : String]()
            settings[ZYY_SET_OPT_BUILD_COUNT] =
              get_setting(with: ZYY_SET_OPT_BUILD_COUNT)
            settings[ZYY_SET_OPT_INDEX_UPDATE_TIME] =
              get_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME)
            settings[ZYY_SET_OPT_TITLE] =
              get_setting(with: ZYY_SET_OPT_TITLE)
            settings[ZYY_SET_OPT_URL] =
              get_setting(with: ZYY_SET_OPT_URL)
            settings[ZYY_SET_OPT_AUTHOR] =
              get_setting(with: ZYY_SET_OPT_AUTHOR)
            settings[ZYY_SET_OPT_START_YEAR] =
              get_setting(with: ZYY_SET_OPT_START_YEAR)
            settings[ZYY_SET_OPT_CUSTOM_HEAD] =
              get_setting(with: ZYY_SET_OPT_CUSTOM_HEAD)
            settings[ZYY_SET_OPT_CUSTOM_MD] =
              get_setting(with: ZYY_SET_OPT_CUSTOM_MD)
            for field in ZYY_SET_OPT_CUSTOM_FIELDS {
                settings[field] = get_setting(with: field)
            }
            for url in ZYY_SET_OPT_CUSTOM_FIELD_URLS {
                settings[url] = get_setting(with: url)
            }

            HTML(
              pages: pages,
              sections: sections,
              settings: settings
            ).write_to_file()
        }
    }
}
