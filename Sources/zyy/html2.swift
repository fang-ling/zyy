//
//  html.swift
//
//
//  Created by Fang Ling on 2022/11/7.
//

import Foundation
import CMark

/* Main index html:
 * <!doctype html>
 * <html>
 *   <head>
 *     <meta>
 *     <meta>
 *     <link>
 *     <style></style>
 *     <title></title>
 *   </head>
 * </html>
 */

struct HTML2 {
//    private static let FONT_LINK = "https://fonts.googleapis.com/css?family=" +
//                       "Gentium+Book+Basic:400,700italic,700,400italic:latin"
//    private static let MAIN_STYLE_CSS_FILENAME = "style.css"
//    private static let CHL_CSS_FILENAME = "gist-embed.css"
    /* The height of stack preview div is determined by javascript. */

    public static func write_to_file() {
        do {
            /* gist-embed.css */
            try CHL_CSS.write(toFile: CHL_CSS_FILENAME,
                              atomically: true,
                              encoding: .utf8)
            /* style.css */
            try MAIN_STYLE_CSS.write(toFile: MAIN_STYLE_CSS_FILENAME,
                                     atomically: true,
                                     encoding: .utf8)
            let index_t = ""
//                zyy.get_setting(field: ZYY_SET_OPT_INDEX_UPDATE_TIME)
            /* index.html */
            try HTML2.render_index(date: index_t).write(toFile: "index.html",
                                                       atomically: true,
                                                       encoding: .utf8)
            // TO-DO: add file hierarch
            for page in zyy.list_pages() {
                try HTML2.render_page(page: page)
                .write(toFile: page.link.components(separatedBy: "/").last!,
                       atomically: true,
                       encoding: .utf8)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    //private static func render_head(titleText : String) -> DOMTreeNode {
        // let head = DOMTreeNode(name: "head", attr: [:])
//         head.add(DOMTreeNode(name: "meta", attr: ["charset" : "UTF-8"]))
//         head.add(DOMTreeNode(
//             name: "meta",
//             attr: ["name" : "viewport",
//                    "content" : "width=device-width initial-scale=1"]))
//         head.add(DOMTreeNode(name: "link", attr: ["href" : FONT_LINK,
//                                                   "rel" : "stylesheet",
//                                                   "type" : "text/css"]))
//         head.add(DOMTreeNode(name: "link",
//                              attr: ["href" : MAIN_STYLE_CSS_FILENAME,
//                                     "rel" : "stylesheet",
//                                     "type" : "text/css"]))
//         let title = DOMTreeNode(name: "title", attr: [:])
//         title.add(titleText)
//         head.add(title)
//         let custom_head = ""
// //        zyy.get_setting(field: ZYY_SET_OPT_CUSTOM_HEAD).from_base64()!
//         head.add(custom_head)
        //return head
    //}




}
