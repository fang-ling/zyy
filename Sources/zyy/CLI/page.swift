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

        func run() {
            /* Write empty header to temp file */
            try! get_page_header(page: nil).write(toFile: ZYY_MD_TEMP,
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
            try! FileManager.default.removeItem(atPath: ZYY_MD_TEMP)
        }
    }
}

 //    struct Add : ParsableCommand {
 //        static var configuration = CommandConfiguration(
 //            abstract: ""
 //        )

 //        @Argument(help: "The title of the new page.")
 //        var title : String

 //        func run() {
//            var page = zyy.get_page(by: title)
//            if page.title == title {
//                command_line_error("Already existed:\n" + title)
//            }
//            page.date = get_current_date_string()
//            page.title = title
//            page.content = ""
//            print("Content:")
//            do {
//                try page.content.write(toFile: zyy.TEMP_FILENAME,
//                                       atomically: true,
//                                       encoding: .utf8)
//                //TO-DO: support different editors
//                try PosixProcess("/usr/local/bin/emacs",
//                                 zyy.TEMP_FILENAME).spawn()
//                page.content = try String(contentsOfFile: zyy.TEMP_FILENAME,
//                                          encoding: .utf8)
//                try PosixProcess("/bin/rm", zyy.TEMP_FILENAME).spawn()
//            } catch {
//                command_line_error(error.localizedDescription)
//            }
//            print("Website link (relative):")
//            page.link = readLine() ?? ""
//            zyy.set_page(page)
    //     }
    // }

    // struct Edit : ParsableCommand {
    //     static var configuration = CommandConfiguration(
    //         abstract: "Modify the page."
    //     )

    //     @Argument(help: "The title of the page.")
    //     var title : String

    //     func run() {
//            var page = zyy.get_page(by: title)
//            if page.title != title {
//                command_line_error("No such section:\n" + title)
//            }
//            page.date = get_current_date_string()
//            print("Hint: Press enter directly to leave it as-is")
//            print("Title[\(page.title)]:")
//            let _title = readLine() ?? ""
//            if _title != "" {
//                page.title = _title
//            }
//            do {
//                try page.content.write(toFile: zyy.TEMP_FILENAME,
//                                       atomically: true,
//                                       encoding: .utf8)
//                //TO-DO: support different editors
//                try PosixProcess("/usr/local/bin/emacs",
//                                 zyy.TEMP_FILENAME).spawn()
//                page.content = try String(contentsOfFile: zyy.TEMP_FILENAME,
//                                          encoding: .utf8)
//                try PosixProcess("/bin/rm", zyy.TEMP_FILENAME).spawn()
//            } catch {
//                command_line_error(error.localizedDescription)
//            }
//            print("Website link (relative)[\(page.link)]:")
//            let link = readLine() ?? ""
//            if link != "" {
//                page.link = link
//            }
//            zyy.remove_page(title: title) /* remove old title (if changed) */
//            zyy.set_page(page)
    //     }
    // }

    // struct Remove : ParsableCommand {
    //     static var configuration = CommandConfiguration(
    //         abstract: "Remove the page."
    //     )

    //     @Argument(help: "The title of the page.")
    //     var title : String

    //     func run() {
//            let page = zyy.get_page(by: title)
//            if page.title != title {
//                command_line_error("No such page:\n" + title)
//            }
//            zyy.remove_page(title: title)
//         }
//     }
// }
