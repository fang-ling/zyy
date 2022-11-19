//
//  html.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

import Foundation

//struct html {
//    func renderLine(withBR br : Bool) -> String {
//        return "<div style='border-bottom: 1px solid #000'></div>" +
//               (br ? "<br>" : "")
//    }
    
    /*
     *  index.html struct:
     *  html
     *      head
     *
     *      body
     *
     *          content
     *              write
     *                  nav
     *                  line
     *                  br
     *                  ol 1
     *                  ...
     *                  ol n
     *                  line
     *                  br
     *                  footer
     *
     */
//    func renderIndex() -> String {
//        // render line
//        let line = Node(renderLine(withBR: true))
////        // render br
////        let br = Node("<br>")
//    }
//}
//
//
//        // render posts (which is several ols)
//        let posts = self.get(in : "Posts", col: "id,created,title")
//        var post = ""
//        for i in posts.indices {
//            // getting tags for each post by querying
//            var cates = ""
//            for j in self.get(under: "Categories", in: "Posts", with: Int(posts[i]["id"]!!)!/*getPostsWithCategories(pid: )!*/) {
//                cates += j["name"]!!/* + ", "*/
//            }
////             delete extraneous ", "
////            cates = String(cates.dropLast(2))
//            // setting date format
//            let date = Date(timeIntervalSince1970:
//                                          TimeInterval(posts[i]["created"]!!)!)
//            let dateFormatter = DateFormatter()
//            dateFormatter.locale = Locale(identifier: "en_US")
//            dateFormatter.dateFormat = "MMM d, yyyy"
//            let dateRep = dateFormatter.string(from: date)
//
//            // date
//            let sSpan1 = Node(left: Node("<strong><span>"),
//                              right: Node("</span></strong>"),
//                              "\(dateRep)")
//            // tag
//            let span2 = Node(left: Node("<span>"),
//                             right: Node("</span>"),
//                             " - [\(cates)] ")
//            // post title
//            let span3 = Node(left: Node("<span>"),
//                             right: Node("</span>"),
//                             posts[i]["title"]!!)
//            let a=Node(left:Node("<a href=\"./post/\(posts[i]["id"]!!).html\">"),
//                       right: Node("</a>"),
//                       span3.toString())
//            let li = Node(left: Node("<li>"),
//                          right: Node("</li>"),
//                          sSpan1.toString() + span2.toString() + a.toString())
//            // each post
//            let ol = Node(left: Node("<ol start=\"\(i + 1)\">"),
//                          right: Node("</ol>"),
//                          li.toString())
//
//            post += ol.toString()
//        }
//        // render footer
//        let footer = Node(self.getFooter())
//        // render write
//        let write = Node(left: Node(#"<div id="write" class="">"#),
//                         right: Node("</div>"),
//                         self.getNav()+line.toString() + br.toString() + post +
//                         line.toString() + br.toString() + footer.toString())
//        // render content
//        let content = Node(left: Node(#"<div class="typora-export-content">"#),
//                           right: Node("</div>"),
//                           write.toString())
//        // render body
//        let body = Node(left: Node(#"<body class="typora-export">"#),
//                        right: Node("<body>"),
//                        content.toString())
//        let head = Node(self.getHeader(title: siteName,
//                                       description: siteDescription))
//
//        let html = Node(left: Node("<!DOCTYPE html><html>"),
//                        right: Node("</html>"),
//                        head.toString() + body.toString())
//
//        return html.toString()
//    }
//}
