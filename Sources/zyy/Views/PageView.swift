//
//  PageView.swift
//
//
//  Created by Fang Ling on 2023/5/17.
//

import ArgumentParser
import Foundation

//private func get_page_header(page : PageModel?) -> String {
//  return
//      """
//      \(ZYY_PAGE_COL_TITLE) = \(page == nil ? "" : page!.title)
//      \(ZYY_PAGE_COL_LINK) = \(page == nil ? "" : page!.link)
//      \(ZYY_PAGE_COL_IS_HIDDEN) = \(page == nil ? 0 : page!.is_hidden)
//      \(ZYY_PAGE_COL_IS_BLOG) = \(page == nil ? 0 : page!.is_blog)
//      \(ZYY_PAGE_COL_ARTWORK) = \(page == nil ? "" : page!.artwork)
//      ###
//      \(page == nil ? "" : page!.content)
//      
//      """
//}

//private func parse_page_file(page_file : String) -> PageModel {
//  var comp = page_file.components(separatedBy: "###")
//  guard let header_str = comp.first else {
//    fatalError("Failed to parse page file")
//  }
//  
//  var page = PageModel()
//  for row in header_str.components(separatedBy: .newlines) {
//    let entry = (row + " ").components(separatedBy: "=")
//    if (
//      entry.first!.trimmingCharacters(in: .whitespaces) == ZYY_PAGE_COL_TITLE
//    ) {
//      page.title = entry.last!.trimmingCharacters(in: .whitespaces)
//    } else if (
//      entry.first!.trimmingCharacters(in: .whitespaces) == ZYY_PAGE_COL_LINK
//    ) {
//      page.link = entry.last!.trimmingCharacters(in: .whitespaces)
//    } else if (
//      entry[0].trimmingCharacters(in: .whitespaces) == ZYY_PAGE_COL_IS_HIDDEN
//    ) {
//      page.is_hidden = Int(entry[1].trimmingCharacters(in: .whitespaces)) ?? 0
//    } else if (
//      entry[0].trimmingCharacters(in: .whitespaces) == ZYY_PAGE_COL_IS_BLOG
//    ) {
//      page.is_blog = Int(entry[1].trimmingCharacters(in: .whitespaces)) ?? 0
//    } else if (
//      entry[0].trimmingCharacters(in: .whitespaces) == ZYY_PAGE_COL_ARTWORK
//    ) {
//      page.artwork = entry[1].trimmingCharacters(in: .whitespaces)
//    }
//  }
//  comp.removeFirst()
//  /*
//   * Don't known where the extraneous leading newlines come from. Trim it
//   * unconditionally.
//   */
//  page.content = comp.joined(
//    separator: "###"
//  ).trimmingCharacters(in: .newlines) + "\n"
//  page.date = get_current_date_string()
//  return page
//}

extension zyy {
  struct Page: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Placeholder",
      subcommands: [Add.self]
    )
  }
//  struct List : ParsableCommand {
//    static var configuration = CommandConfiguration(
//      abstract: "List all pages."
//    )
//    
//    func run() {
//      let db = DatabaseDriver()
//      
//      print("PAGEID|TITLE")
//      for page in db.get_pages() {
//        print("\(String(format: "%6d", page.id))|\(page.title)")
//      }
//    }
//  }
  
  
  
//  struct Add: ParsableCommand {
//    static var configuration = CommandConfiguration(
//      abstract: "Add new page."
//    )
//    
//    func run() throws {
//      
//      let db = DatabaseDriver()
//      
//      /* Write empty header to temp file */
//      try get_page_header(page: nil).write(toFile: ZYY_MD_TEMP,
//                                           atomically: true,
//                                           encoding: .utf8)
//      /* Launch command line editor */
//      posix_spawn(db.get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
//      /* Read page file */
//      let page_file = try! String(contentsOfFile: ZYY_MD_TEMP,
//                                  encoding: .utf8)
//      var page = parse_page_file(page_file: page_file)
//      page.date_created = get_current_date_string() /* The only write */
//      /* Write to database */
//      db.add_page(page)
//      /* Remove temp file */
//      try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
    }
//  }
  
//  struct Edit : ParsableCommand {
//    static var configuration = CommandConfiguration(
//      abstract: "Modify the page."
//    )
//    
//    @Argument(help: "The id of the page.")
//    var id : Int
//    
//    func run() throws {
//      let db = DatabaseDriver()
//      
//      guard let page = db.get_page(by: id) else {
//        fatalError("No such page with id \(id).")
//      }
//      /* Write header to temp file */
//      try get_page_header(page: page).write(toFile: ZYY_MD_TEMP,
//                                            atomically: true,
//                                            encoding: .utf8)
//      /* Launch command line editor */
//      posix_spawn(db.get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
//      /* Read page file */
//      let page_file = try! String(contentsOfFile: ZYY_MD_TEMP,
//                                  encoding: .utf8)
//      var new_page = parse_page_file(page_file: page_file)
//      /*
//       * The following field(s) are not user changeable, so they need to be
//       * copied.
//       */
//      new_page.id = page.id
//      new_page.date_created = page.date_created
//      /* Write to database */
//      db.set_page(new_page)
//      /* Remove temp file */
//      try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
//    }
//  }
//  
//  struct Remove : ParsableCommand {
//    static var configuration = CommandConfiguration(
//      abstract: "Remove the page."
//    )
//    
//    @Argument(help: "The id of the page.")
//    var id : Int
//    
//    func run() throws {
//      let db = DatabaseDriver()
//      
//      /* It's not necessary to check if the page exists. */
//      db.remove_page(by: id)
//    }
//  }
//}

extension zyy.Page {
  struct Add: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Add new page."
    )
    
    @MainActor 
    func run() throws {
      let pageDTO = PageDTO(
        title: "4",
        content: "1",
        link: "1",
        date: Date(),
        isHidden: false,
        isBlog: true,
        createdAt: Date(),
        artworkLink: "1"
      )
      PageController.default.create(pageDTO: pageDTO)
    }
  }
}
