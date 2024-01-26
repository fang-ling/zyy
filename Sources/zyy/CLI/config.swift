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
    
    private func get_section_file(sections : [Section]) -> String {
      var result = ""
      if sections.isEmpty {
        result += """
                          1
                          heading =
                          caption =
                          cover =
                          hlink =
                          clink =
                          
                          """
      } else {
        var i = 1
        for section in sections {
          result += """
                              \(i)
                              heading = \(section.heading)
                              caption = \(section.caption)
                              cover = \(section.cover)
                              hlink = \(section.hlink)
                              clink = \(section.clink)
                              
                              """
          i += 1
        }
      }
      return result
    }
    
    private func parse_section_file(_ file : String) -> [Section] {
      var contents = file.components(separatedBy: .newlines)
      /// Ignore empty lines and line with pure number
      contents.removeAll(where: { $0.is_int() || $0 == "" })
      var sections = [Section]()
      var i = 0
      while i < contents.count {
        var section = Section()
        section.heading =
        (contents[i] + " ").components(separatedBy: "=")[1]
          .trimmingCharacters(in: .whitespaces)
        section.caption =
        (contents[i + 1] + " ").components(separatedBy: "=")[1]
          .trimmingCharacters(in: .whitespaces)
        section.cover =
        (contents[i + 2] + " ").components(separatedBy: "=")[1]
          .trimmingCharacters(in: .whitespaces)
        section.hlink =
        (contents[i + 3] + " ").components(separatedBy: "=")[1]
          .trimmingCharacters(in: .whitespaces)
        section.clink =
        (contents[i + 4] + " ").components(separatedBy: "=")[1]
          .trimmingCharacters(in: .whitespaces)
        
        sections.append(section)
        i += 5
      }
      return sections
    }
    
    /// Config file format:
    /// optionX = valueX
    /// "valueX" can be empty to indicate no such value.
    /// Everything behind '#' in a single line will be removed.
    func run() throws {
      let db = DatabaseDriver()
      
      func get_config_file() -> String {
        /* List user-editable settings */
        var config =
    """
    # Command line text editor (absolute path)
    \(ZYY_SET_OPT_EDITOR) = \(db.get_setting(with: ZYY_SET_OPT_EDITOR)!)
    # The title of your website
    \(ZYY_SET_OPT_TITLE) = \(db.get_setting(with: ZYY_SET_OPT_TITLE)!)
    # The URL of your website, please set it as index.html
    \(ZYY_SET_OPT_URL) = \(db.get_setting(with: ZYY_SET_OPT_URL)!)
    # Your name
    \(ZYY_SET_OPT_AUTHOR) = \(db.get_setting(with: ZYY_SET_OPT_AUTHOR)!)
    # The start year of your website
    \(ZYY_SET_OPT_START_YEAR) = \(db.get_setting(with: ZYY_SET_OPT_START_YEAR)!)
    # Custom fields in head box
    
    """
        for i in zip(
          ZYY_SET_OPT_CUSTOM_FIELDS,
          ZYY_SET_OPT_CUSTOM_FIELD_URLS
        ) {
          config += """
                    \(i.0) = \(db.get_setting(with: i.0)!)
                    \(i.1) = \(db.get_setting(with: i.1)!)
                    
                    """
        }
        /*config +=
         """
         # Custom HTML code in <head></head> tag
         \(ZYY_SET_OPT_CUSTOM_HEAD) = \(get_setting(with: ZYY_SET_OPT_CUSTOM_HEAD)!)
         # Custom MARKDOWN text on index.html
         \(ZYY_SET_OPT_CUSTOM_MD) = \(get_setting(with: ZYY_SET_OPT_CUSTOM_MD)!)
         """*/
        return config
      }
      
      
      /* Check if database exists */
      if !FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
        fatal_error(.no_such_file)
      }
      /* Update index page modified time unconditionally. */
      db.set_setting(
        with: ZYY_SET_OPT_INDEX_UPDATE_TIME,
        new: get_current_date_string()
      )
      
      
      /* Write config to temporary file */
      try get_config_file().write(toFile: ZYY_CONFIG_TEMP,
                                  atomically: true,
                                  encoding: .utf8)
      /* Launch command line editor */
      posix_spawn(db.get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_CONFIG_TEMP)
      /* Read config file */
      let config = try! String(contentsOfFile: ZYY_CONFIG_TEMP,
                               encoding: .utf8)
      let settings = parse_config_file(config)
      /* Write settings to database */
      db.set_settings(settings)
      /* Remove the temporary file */
      try FileManager.default.removeItem(atPath: ZYY_CONFIG_TEMP)
      
      var custom_head = db.get_setting(with: ZYY_SET_OPT_CUSTOM_HEAD)!
      /* Write custom head to temporary file */
      try custom_head.write(
        toFile: ZYY_MD_TEMP,
        atomically: true,
        encoding: .utf8
      )
      /* Launch command line editor */
      posix_spawn(db.get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
      /* Read custom head */
      custom_head = try! String(
        contentsOfFile: ZYY_MD_TEMP,
        encoding: .utf8
      )
      /* Write settings to database */
      db.set_setting(with: ZYY_SET_OPT_CUSTOM_HEAD, new: custom_head)
      /* Remove the temporary file */
      try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
      
      var custom_md = db.get_setting(with: ZYY_SET_OPT_CUSTOM_MD)!
      /* Write custom markdown to temporary file */
      try custom_md.write(
        toFile: ZYY_MD_TEMP,
        atomically: true,
        encoding: .utf8
      )
      /* Launch command line editor */
      posix_spawn(db.get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
      /* Read custom head */
      custom_md = try! String(
        contentsOfFile: ZYY_MD_TEMP,
        encoding: .utf8
      )
      /* Write settings to database */
      db.set_setting(with: ZYY_SET_OPT_CUSTOM_MD, new: custom_md)
      /* Remove the temporary file */
      try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
      
      /* Get all of the sections */
      var sections = db.get_sections()
      /* Clear Section table */
      db.remove_sections()
      /* Write sections to temporary file */
      try get_section_file(sections: sections).write(toFile: ZYY_MD_TEMP,
                                                     atomically: true,
                                                     encoding: .utf8)
      /* Launch command line editor */
      posix_spawn(db.get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
      /* Read section file */
      let file = try! String(contentsOfFile: ZYY_MD_TEMP, encoding: .utf8)
      sections = parse_section_file(file)
      /* Write sections to database */
      db.add_sections(sections)
      /* Remove the temporary file */
      try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
    }
  }
}
