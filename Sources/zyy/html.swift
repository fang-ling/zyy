//
//  html.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

import Foundation

/* Main index html:
 * <!doctype html>
 * <html>
 *   <head>
 *     <meta>
 *     <meta>
 *     <link>
 *   </head>
 * </html>
 */

struct HTML {
    private static let FONT_LINK = "https://fonts.loli.net/css?family=PT+Serif:400,400italic,700,700italic&subset=latin,cyrillic-ext,cyrillic,latin-ext"
    
    private static func render_doctype() -> TreeNode {
        return TreeNode(begin: "<!doctype html>", end: "")
    }
    
    /* Void elements only have a start tag; end tags must not be specified for
     * void elements. */
    private static func render_meta(attribute : String) -> TreeNode {
        return TreeNode(begin: "<meta \(attribute)>", end: "")
    }
    
    private static func render_link(attribute : String) -> TreeNode {
        return TreeNode(begin: "<link \(attribute)>", end: "")
    }
    
    private static func render_style(attribute : String,
                                     content : String) -> TreeNode {
        return TreeNode(begin: "<style \(attribute)>",
                        content: content,
                        end: "</style>")
    }
    
    private static func render_title(content : String) -> TreeNode {
        return TreeNode(begin: "<title>", content: content, end: "</title>")
    }
    
    public static func render_head(title : String) -> TreeNode {
        var head = TreeNode(begin: "<head>", end: "</head>")
        head.child.append(render_meta(attribute: "charset='UTF-8'"))
        head.child.append(render_meta(attribute: "name='viewport' " +
                                "content='width=device-width initial-scale=1'"))
        head.child.append(render_link(attribute: "href='https://fonts" +
                                ".loli.net/css?family=PT+Serif:400,400italic," +
                                "700,700italic&subset=latin,cyrillic-ext,cyri" +
                                "llic,latin-ext' rel='stylesheet'" +
                                "type='text/css'"))
        return head
    }

}
