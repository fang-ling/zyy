//
//  page.swift
//
//
//  Created by Fang Ling on 2023/5/17.
//

import ArgumentParser
import Foundation

private func get_page_header(page : Page?) -> String {
    return
      """
      \(ZYY_PAGE_COL_TITLE) = \(page == nil ? "" : page!.title)
      \(ZYY_PAGE_COL_LINK) = \(page == nil ? "" : page!.link)
      ###
      \(page == nil ? "" : page!.content)

      """
}

private func parse_page_file(page_file : String) -> Page {
    var comp = page_file.components(separatedBy: "###")
    guard let header_str = comp.first else {
        fatalError("Failed to parse page file")
    }

    var page = Page()
    for row in header_str.components(separatedBy: .newlines) {
        let entry = (row + " ").components(separatedBy: "=")
        if entry.first!.trimmingCharacters(in: .whitespaces) ==
             ZYY_PAGE_COL_TITLE {
            page.title = entry.last!.trimmingCharacters(in: .whitespaces)
        } else if entry.first!.trimmingCharacters(in: .whitespaces) ==
                    ZYY_PAGE_COL_LINK {
            page.link = entry.last!.trimmingCharacters(in: .whitespaces)
        }
    }
    comp.removeFirst()
    page.content = comp.joined(separator: "###")
    page.date = get_current_date_string()
    return page
}



extension zyy {
    struct List : ParsableCommand {
        static var configuration = CommandConfiguration(
          abstract: "List all pages."
        )

        func run() {
            print("PAGEID|TITLE")
            for page in get_pages() {
                print("\(String(format: "%6d", page.id))|\(page.title)")
            }
        }
    }

    struct Add : ParsableCommand {
        static var configuration = CommandConfiguration(
          abstract: "Add new page."
        )

        func run() throws {
            /* Write empty header to temp file */
            try get_page_header(page: nil).write(toFile: ZYY_MD_TEMP,
                                                 atomically: true,
                                                 encoding: .utf8)
            /* Launch command line editor */
            posix_spawn(get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
            /* Read page file */
            let page_file = try! String(contentsOfFile: ZYY_MD_TEMP,
                                        encoding: .utf8)
            let page = parse_page_file(page_file: page_file)
            /* Write to database */
            add_page(page: page)
            /* Remove temp file */
            try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
        }
    }

    struct Edit : ParsableCommand {
        static var configuration = CommandConfiguration(
          abstract: "Modify the page."
        )

        @Argument(help: "The id of the page.")
        var id : Int

        func run() throws {
            guard let page = get_page(by: id) else {
                fatalError("No such page with id \(id).")
            }
            /* Write header to temp file */
            try get_page_header(page: page).write(toFile: ZYY_MD_TEMP,
                                                  atomically: true,
                                                  encoding: .utf8)
            /* Launch command line editor */
            posix_spawn(get_setting(with: ZYY_SET_OPT_EDITOR)!, ZYY_MD_TEMP)
            /* Read page file */
            let page_file = try! String(contentsOfFile: ZYY_MD_TEMP,
                                        encoding: .utf8)
            var new_page = parse_page_file(page_file: page_file)
            new_page.id = page.id /// Be careful
            /* Write to database */
            set_page(page: new_page)
            /* Remove temp file */
            try FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
        }
    }

    struct Remove : ParsableCommand {
         static var configuration = CommandConfiguration(
           abstract: "Remove the page."
         )

         @Argument(help: "The id of the page.")
         var id : Int

         func run() throws {
             /* It's not necessary to check if the page exists. */
             remove_page(id: id)
         }
    }
}
