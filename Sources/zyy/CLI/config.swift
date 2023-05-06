//
//  config.swift
//  
//
//  Created by Fang Ling on 2023/5/6.
//

import Foundation
import ArgumentParser

extension zyy {
    struct Config : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Set up the website."
        )
        
        private func get_config_file() -> String {
            /* List user-editable settings */
            var config =
    """
    # Command line text editor (absolute path)
    \(ZYY_SET_OPT_EDITOR) = \(get_setting(with: ZYY_SET_OPT_EDITOR)!)
    # The title of your website
    \(ZYY_SET_OPT_TITLE) = \(get_setting(with: ZYY_SET_OPT_TITLE)!)
    # The URL of your website, must starts with http:// or https://
    \(ZYY_SET_OPT_URL) = \(get_setting(with: ZYY_SET_OPT_URL)!)
    # Your name
    \(ZYY_SET_OPT_AUTHOR) = \(get_setting(with: ZYY_SET_OPT_AUTHOR)!)
    # The start year of your website
    \(ZYY_SET_OPT_START_YEAR) = \(get_setting(with: ZYY_SET_OPT_START_YEAR)!)
    # Custom fields in head box
    
    """
            for i in zip(ZYY_SET_OPT_CUSTOM_FIELDS,
                         ZYY_SET_OPT_CUSTOM_FIELD_URLS) {
                config += """
                          \(i.0) = \(get_setting(with: i.0)!)
                          \(i.1) = \(get_setting(with: i.1)!)
                          
                          """
            }
            config +=
    """
    # Custom HTML code in <head></head> tag
    \(ZYY_SET_OPT_CUSTOM_HEAD) = \(get_setting(with: ZYY_SET_OPT_CUSTOM_HEAD)!)
    # Custom MARKDOWN text on index.html
    \(ZYY_SET_OPT_CUSTOM_MD) = \(get_setting(with: ZYY_SET_OPT_CUSTOM_MD)!)
    """
            return config
        }
        
        private
        func parse_config_file(_ config : String) -> [(String, String)] {
            var contents = config.components(separatedBy: .newlines)
            /// Ignore comments and empty lines
            contents.removeAll(where: { $0.hasPrefix("#") || $0 == "" })
            var settings = [(String, String)]()
            for content in contents {
                /* Some editor may trim trailing spaces. */
                let delta = (content + " ").components(separatedBy: "=")
                settings.append((delta[0].trimmingCharacters(in: .whitespaces),
                                 delta[1].trimmingCharacters(in: .whitespaces)))
            }
            return settings
        }
        
        /// Config file format:
        /// optionX = valueX
        /// "valueX" can be empty to indicate no such value.
        /// Everything behind '#' in a single line will be removed.
        func run() {
            /* Check if database exists */
            if !FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
                fatal_error(.no_such_file)
            }
            /* Update index page modified time unconditionally. */
            set_setting(with: ZYY_SET_OPT_INDEX_UPDATE_TIME,
                        new_value: get_current_date_string())
            
            /* Write config to temporary file */
            try! get_config_file().write(toFile: ZYY_CONFIG_TEMP,
                                         atomically: true,
                                         encoding: .utf8)
            /* Launch command line editor */
            posix_spawn(get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_CONFIG_TEMP)
            /* Read config file */
            let config = try! String(contentsOfFile: ZYY_CONFIG_TEMP,
                                     encoding: .utf8)
            let settings = parse_config_file(config)
            /* Write settings to database */
            set_settings(option_value_pairs: settings)
            /* Remove the temporary file */
            try! FileManager.default.removeItem(atPath: ZYY_CONFIG_TEMP)
        }
    }
}
