//
//  page.swift
//
//
//  Created by Fang Ling on 2023/5/17.
//

import ArgumentParser
import Foundation

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
}

 // extension zyy.PageCommand {
 //    struct List : ParsableCommand {
 //        static var configuration = CommandConfiguration(
 //            abstract: "List all pages."
 //        )

 //        func run() {
 //            for i in zyy.list_pages() {
 //                print(i.title)
 //            }
 //        }
 //    }

 //    struct Add : ParsableCommand {
 //        static var configuration = CommandConfiguration(
 //            abstract: "Add new page"
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
