//
//  html.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

import Foundation
import CMark

let MAIN_STYLE_CSS : String =
"""
:root {
    --monospace: ui-monospace,SFMono-Regular,SF Mono,Menlo,Consolas,Liberation Mono,monospace;
    /* <code> tag color */
    --color-neutral-muted: rgba(175, 184, 193, 0.2);
    --bg-color: #FFFBF5;
    --text-color: #1f0909;
    --text-font: 'Gentium Book Basic', system-ui, serif;
    /* table child 2n bg color */
    --color-canvas-subtle: #e8e7e7;
    --color-canvas-head: #dadada;
    /* table border color */
    --color-border-default: #d0d7de; /* dark: #30363d */
    --color-border-muted: hsla(210,18%,87%,1); /* dark: #21262d */
    /* purple box color */
    --purple-box-color: #674188;
    /* purple box font color */
    --purple-box-font-color: #F7EFE5;
    /* purple box light purple */
    --purple-box-light-color: #C3ACD0;
    /* purple box link color */
    --purple-box-link-color: yellow;

    /* gist */
    --color-canvas-default: #ffffff;
    --color-fg-default: #24292f;
    --gist-border-pcolor: #ddd;
    --gist-border-scolor: #ccc;
}

html {
    background-color: var(--bg-color);
    color: var(--text-color);
    font-size: 16px;
}

body {
    margin: 0 auto;
    font-size: 1rem;
    padding-left: 30px;
    padding-right: 30px;
    font-family: var(--text-font);
    max-width: 50em;
    line-height: 1.5em;
}

blockquote {
    padding: 0 1em;
    border-left: .25em solid var(--purple-box-color);
}

img {
    vertical-align: middle;
}

.title-text {
    border-bottom: none;
    font-variant: small-caps;
    padding-bottom: 0em;
    text-shadow: 2px 2px 2px #aaa;
    font-size: 250%;
    text-align: center;
    margin-bottom: .5em;
}

code {
    font-family: var(--monospace);
    padding: .2em .4em;
    background-color: var(--color-neutral-muted);
    border-radius: 6px;
    font-size: 85%;
}

A:link, A:visited {
    text-decoration: none;
    color: var(--purple-box-color)
}

A:hover {
    background-color: var(--purple-box-color);
    color: var(--purple-box-light-color);
    text-decoration: none
}

.purplebox A:link, .purplebox A:visited {
    text-decoration: none;
    color: var(--purple-box-link-color);
}

.purplebox A:hover {
    background-color: var(--purple-box-link-color);
    color: var(--purple-box-color);
    text-decoration: none
}

.purplebox A:link, .purplebox A:visited {
    text-decoration: none;
    color: var(--purple-box-link-color);
}

.purplebox A:hover {
    background-color: var(--purple-box-link-color);
    color: var(--purple-box-color);
    text-decoration: none
}

.stackpreview-container {
    text-align: center;
}

.stackpreview {
    display: inline-block;
    margin: 3ex 1em;
    padding: 4px;
    clear: both;
    text-align: center;
    background-color: var(--purple-box-light-color);
    vertical-align: top;
    width: 300px;
}

.stackpreview P {
    margin-top: 0;
    white-space: normal;
}

.stackpreview DIV+P,
.stackpreview P+P {
    margin-bottom: 0.5em
}

.image A IMG,
.image A TABLE {
    border: 4px solid var(--purple-box-color);
    position: relative;
    left: -4px;
    top: -4px
}

.image A:hover IMG,
.image A:hover TABLE {
    border-color: var(--purple-box-light-color);
    opacity: .5
}

.image A:hover {
    background-color: inherit
}

.heading {
    font-size: x-large;
    font-weight: bold;
}

.caption {
    font-style: italic
}

.purplebox, .section {
    background: var(--purple-box-color);
    color: var(--purple-box-font-color);
    padding: 1ex 1em;
    font-weight: bold;
    font-size: large;
}

.section {
    text-transform: uppercase;
    padding: 0.5ex 0.5em;
    font-size: 1.5em;
}

.head-box {
    text-align: center;
}

.foot-box {
    margin-top: 0.5em;
    text-align: right;
}

.footer {
    text-align: center;
}

.footer a, .footer span {
    margin-left: 4px;
    color: var(--purple-box-font-color) !important;
    text-decoration: none;
    font-size: 13px;
    padding: 4px 8px;
    border-radius: 3px;
    background: var(--purple-box-color) !important;
}

#reset-all {
    background-color: unset;
}

ol li {
    list-style-type: decimal;
}

ul li {
    list-style-type: disc;
}

li ol>li {
    list-style-type: lower-alpha
}

li li ol>li {
    list-style-type: lower-roman
}

table thead {
    background: var(--color-canvas-head);
    text-transform: uppercase;
}

table {
    border-spacing: 0;
    border-collapse: collapse;
}

table td, table th {
    padding: 6px 13px;
    /*border: 1px solid var(--color-border-default);*/
}

/*table tr {
    border-top: 1px solid var(--color-border-muted);
}*/

tr:nth-child(2n) {
    background: var(--color-canvas-subtle);
}

/* MathJax long formulas */
/*mjx-container {
  display: inline-grid;
  overflow-x: auto;
  overflow-y: hidden;
  max-width: 100%;
}*/

/* iPhone OS */
@media screen and (max-width:500px) {
    body {
        padding-left: 20px;
        padding-right: 20px;
        /* fix gist font size bug on iPhone OS */
        -webkit-text-size-adjust: 100%;
    }
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
    :root {
        --bg-color: #222831;
        --text-color: #fff4ff;
        --purple-box-light-color: #63496a;
        --dark-link-pcolor: #BC6FF1;
        --dark-link-scolor: #D9ACF5;
        --dark-page-bg: #393E46;

        /* gist */
        --color-canvas-default: var(--dark-page-bg);
        --color-fg-default: #e4e8ec;
        --gist-border-pcolor: #727477;
        --gist-border-scolor: #727477;
    }

    body {
        max-width: 55em;
    }

    .gist .gist-meta {
        background-color: var(--color-canvas-default) !important;
        color: var(--color-fg-default) !important;
    }

    .gist .gist-meta a {
        color: var(--dark-link-pcolor) !important;
    }

    html {
        font-size: 15px;
    }

    img {
        filter: brightness(.8) contrast(1.2);
    }

    .page-container {
        background-color: var(--dark-page-bg);
        border-radius: 6px 6px;
        padding: 0.1em 1em 0.1em 1em;
        margin-top: 1em;
        margin-bottom: 1em;
    }

    .section {
        padding: 0.9ex 0.5em;
    }

    .title-text {
        color: var(--purple-box-font-color);
    }

    A:link, A:visited {
        text-decoration: none;
        color: var(--dark-link-pcolor)
    }

    A:hover {
        background-color: var(--dark-link-pcolor);
        color: var(--dark-link-scolor);
        text-decoration: none
    }
}
"""

let STACK_PREVIEW_JS =
"""
/* Written by Erik Demaine <edemaine@mit.edu>, 2012.
 * Distributed under the MIT License
 * [http://www.opensource.org/licenses/mit-license.php]
 */
  var divs = document.getElementsByTagName ('div');
  var maxHeight = 0;
  for (var i = 0; i < divs.length; i++) {
    if ((' ' + divs[i].className + ' ').indexOf (' stackpreview ') >= 0) {
      maxHeight = Math.max (maxHeight, divs[i].offsetHeight);
    }
  }
  for (var i = 0; i < divs.length; i++) {
    if ((' ' + divs[i].className + ' ').indexOf (' stackpreview ') >= 0) {
      divs[i].style.height = maxHeight + 'px';
    }
  }
"""

let MATHJAX_JS =
"""
<script>
MathJax = {
  tex: {
    inlineMath: [['$', '$']],
    displayMath: [['$$', '$$']]
  }
};
</script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
"""

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

struct HTML {
    private static let FONT_LINK = "https://fonts.googleapis.com/css?family=" +
                       "Gentium+Book+Basic:400,700italic,700,400italic:latin"
    private static let MAIN_STYLE_CSS_FILENAME = "style.css"
    private static let CHL_CSS_FILENAME = "gist-embed.css"
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
            try HTML.render_index(date: index_t).write(toFile: "index.html",
                                                       atomically: true,
                                                       encoding: .utf8)
            // TO-DO: add file hierarch
            for page in zyy.list_pages() {
                try HTML.render_page(page: page)
                .write(toFile: page.link.components(separatedBy: "/").last!,
                       atomically: true,
                       encoding: .utf8)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private static func render_head(titleText : String) -> DOMTreeNode {
        let head = DOMTreeNode(name: "head", attr: [:])
        head.add(DOMTreeNode(name: "meta", attr: ["charset" : "UTF-8"]))
        head.add(DOMTreeNode(
            name: "meta",
            attr: ["name" : "viewport",
                   "content" : "width=device-width initial-scale=1"]))
        head.add(DOMTreeNode(name: "link", attr: ["href" : FONT_LINK,
                                                  "rel" : "stylesheet",
                                                  "type" : "text/css"]))
        head.add(DOMTreeNode(name: "link",
                             attr: ["href" : MAIN_STYLE_CSS_FILENAME,
                                    "rel" : "stylesheet",
                                    "type" : "text/css"]))
        let title = DOMTreeNode(name: "title", attr: [:])
        title.add(titleText)
        head.add(title)
        let custom_head = ""
//        zyy.get_setting(field: ZYY_SET_OPT_CUSTOM_HEAD).from_base64()!
        head.add(custom_head)
        return head
    }
    
    /*
     *  <h1>
     *      <strong>...</strong>
     *  </h1>
     */
    private static func render_title(title_text : String) -> DOMTreeNode {
        let strong = DOMTreeNode(name: "strong", attr: [:])
        strong.add(title_text)
        let h1 = DOMTreeNode(name: "h1", attr: ["class" : "title-text"])
        h1.add(strong)
        return h1
    }
    
    /*
     *  <div>
     *      Plain text or <a> separated by dots.
     *  </div>
     */
    private static func render_head_box() -> DOMTreeNode {
        let fields = zyy.getAllHeadBoxCustomFields()
        let div = DOMTreeNode(name: "div",
                              attr: ["class" : "purplebox head-box"])
        for i in fields[0].indices {
            if (fields[1][i] == "") { /* Plain text node */
                div.add(fields[0][i])
            } else {
                let a = DOMTreeNode(name: "a", attr: ["href" : fields[1][i]])
                a.add(fields[0][i])
                div.add(a)
            }
            if (i != fields[0].count - 1) { /* Add separater */
                div.add("&nbsp;&bull;&nbsp;");
            }
        }
        return div
    }
    
    private static
    func render_stack_preview(by section : Section) -> DOMTreeNode {
        let stack_preview = DOMTreeNode(name: "div",
                                        attr: ["class" : "stackpreview"])
        /* Image */
        let img_p = DOMTreeNode(name: "p",
                                attr: ["class" : "image"])
        let img_p_a = DOMTreeNode(name: "a", attr: ["href" : section.hlink])
        img_p_a.add(DOMTreeNode(name: "img", attr: ["width" : "300",
                                                    "height" : "300",
                                                    "src" : section.cover]))
        img_p.add(img_p_a)
        /* Heading */
        let heading_p = DOMTreeNode(name: "p",
                                    attr: ["class" : "heading"])
        let heading_p_a = DOMTreeNode(name: "a", attr: ["href" : section.hlink])
        heading_p_a.add(section.heading)
        heading_p.add(heading_p_a)
        /* Caption */
        let caption_p = DOMTreeNode(name: "div",
                                    attr: ["class" : "caption"])
        caption_p.add(cmark_markdown_to_html_with_ext(section.caption,
                                                      CMARK_OPT_UNSAFE))
        stack_preview.add(img_p)
        stack_preview.add(heading_p)
        stack_preview.add(caption_p)
        return stack_preview
    }
    
    private static func render_stack_preview_container() -> DOMTreeNode {
        let div = DOMTreeNode(name: "div",
                              attr: ["class" : "stackpreview-container"])
        for section in zyy.list_sections() {
            div.add(render_stack_preview(by: section))
        }
        return div
    }
    
    private static func render_foot_box(date: String) -> DOMTreeNode {
        let author = ""//zyy.get_setting(field: ZYY_SET_OPT_AUTHOR)
        let site_url = ""//zyy.get_setting(field: ZYY_SET_OPT_URL)
        let div = DOMTreeNode(name: "div",
                              attr: ["class" : "purplebox foot-box"])
        let i = DOMTreeNode(name: "i", attr: [:])
        let a = DOMTreeNode(name: "a", attr: ["href" : site_url])
        a.add(author)
        i.add("Last updated \(date) by ")
        i.add(a)
        i.add(".")
        div.add(i)
        return div
    }
    
    private static func render_footer() -> DOMTreeNode {
        let site_url = ""//zyy.get_setting(field: ZYY_SET_OPT_URL)
        let author = ""//zyy.get_setting(field: ZYY_SET_OPT_AUTHOR)
        let st_year = ""//zyy.get_setting(field: ZYY_SET_OPT_START_YEAR)
        var cr_year = 1970
        if let year = Calendar(identifier: .gregorian)
                            .dateComponents([.year], from: Date()).year {
            cr_year = year
        }
        let div = DOMTreeNode(name: "div", attr: ["class" : "footer"])
        div.add("Made with ♡")
        let a = DOMTreeNode(name: "a", attr: ["href" : site_url])
        a.add("by \(author)")
        div.add(a)
        let a2 = DOMTreeNode(name: "a", attr: ["href" : zyy.GITHUB_REPO])
        a2.add("zyy v\(zyy.VERSION)")
        div.add(a2)
        let span = DOMTreeNode(name: "span",
                               attr: [:])
        let count = ""//zyy.get_setting(field: ZYY_SET_OPT_BUILD_COUNT)
        span.add("Build: \(count)")
        div.add(span)
        let p = DOMTreeNode(name: "p", attr: ["class" : "copyright"])
        p.add("© \(st_year)-\(cr_year) \(author)")
        div.add(p)
        return div
    }
    
    private static func render_index_body(date: String) -> DOMTreeNode {
        let sitename = ""//zyy.get_setting(field: ZYY_SET_OPT_TITLE)
        let body = DOMTreeNode(name: "body", attr: [:])
        body.add(render_title(title_text: sitename))
        body.add(render_head_box())
        body.add(render_stack_preview_container())
        let c_md = ""//zyy.get_setting(field: ZYY_SET_OPT_CUSTOM_MARKDOWN)
//                    .from_base64()!
        body.add(cmark_markdown_to_html_with_ext(c_md, CMARK_OPT_UNSAFE))
        body.add(render_foot_box(date: date))
        body.add(DOMTreeNode(name: "br", attr: [:]))
        body.add(render_footer())
        let js = DOMTreeNode(name: "script", attr: ["type" : "text/javascript"])
        js.add(STACK_PREVIEW_JS)
        body.add(js)
        return body
    }
    
    public static func render_index(date: String) -> String {
        let sitename = ""//zyy.get_setting(field: ZYY_SET_OPT_TITLE)
        let html = DOMTreeNode(name: "html", attr: ["lang" : "en"])
        html.add(render_head(titleText: sitename))
        html.add(render_index_body(date: date))
        var string = ""
        DOMTreeNode.inorder_tree_traversal(html, &string)
        return "<!DOCTYPE html>\n" + string
    }
    
    private static func render_page(page : Page) -> String {
        var page = page
        let html = DOMTreeNode(name: "html", attr: ["lang" : "en"])
        /* Body */
        let body = DOMTreeNode(name: "body", attr: [:])
        body.add(render_title(title_text: page.title))
        body.add(render_head_box())
        
        /* Replace $...$ and $$...$$ with a unique string */
        /* Should not use $ for other purpose. */
        let latex_math = #/(\${1,2})(?:(?!\1)[\s\S])*\1/#
        var formula_to_uuid : [String : String] = [:]
        var uuid_to_origin_formula : [String : String] = [:]
        /* Match all formulas */
        var uuid = ""
        var formula = ""
        var origin_formula = ""
        var has_math = false
        for m in page.content.matches(of: latex_math) {
            has_math = true
            
            uuid = UUID().uuidString
            formula = String(m.output.0)
            origin_formula = formula
            /* Replace < with &lt; and > with &gt; It's required and MathJax
             * render this correctly.
             */
            formula = formula.replacingOccurrences(of: "<", with: "&lt;")
            formula = formula.replacingOccurrences(of: ">", with: "&gt;")
            if origin_formula != formula {
                uuid_to_origin_formula[uuid] = origin_formula
            }
            
            formula_to_uuid[formula] = uuid
        }
        /* Replace formulas with corresponding uuid */
        var o_formula : String? = ""
        for i in formula_to_uuid {
            o_formula = uuid_to_origin_formula[i.value]
            if o_formula == nil { /* not change */
                page.content = page.content.replacingOccurrences(of: i.key,
                                                                 with: i.value)
            } else {
                page.content = page.content.replacingOccurrences(of: o_formula!,
                                                                 with: i.value)
            }
        }
        
        /* Replace code block */
        var has_code = false
        let code_block = #/<code(?:\s[^>]*)?>[\s\S]*?<\/code>|`{3}([\S\s]*?)`{3}|~~([\S\s]*?)~~__([\s\S]*?)__/#
        for m in page.content.matches(of: code_block) {
            has_code = true
            
            var lines = m.output.0.components(separatedBy: .newlines)
            // - TODO: Assuming code block is
            //   ```language
            //   ............
            //   ```
            //
            var lang = lines.removeFirst()
            lang.removeFirst(3)
            lines.removeLast()
            var code = ""
            for i in lines {
                code += i + "\n"
            }
            
            var replace = ""
            DOMTreeNode.inorder_tree_traversal_code(Code.toHTML(code: code,
                                                                language: lang),
                                                    &replace)
            replace = replace.replacingOccurrences(of: "<>", with: "")
            page.content = page.content.replacingOccurrences(of: m.output.0,
                                                             with: replace)
        }
        
        page.content = cmark_markdown_to_html_with_ext(page.content,
                                                       CMARK_OPT_UNSAFE)
        /* Restore formulas after change to html */
        for i in formula_to_uuid {
            page.content = page.content.replacingOccurrences(of: i.value,
                                                             with: i.key)
        }
        //body.add(page.content)
        let page_container = DOMTreeNode(name: "div",
                                         attr: ["class" : "page-container"])
        page_container.add(page.content)
        body.add(page_container)
        body.add(render_foot_box(date: page.date))
        body.add(DOMTreeNode(name: "br", attr: [:]))
        body.add(render_footer())
        
        let head = render_head(titleText: page.title)
        if has_math {
            head.add(MATHJAX_JS)
        }
        if has_code {
            head.add(DOMTreeNode(name: "link",
                                 attr: ["href" : CHL_CSS_FILENAME,
                                        "rel" : "stylesheet",
                                        "type" : "text/css"]))
        }
        html.add(head)
        html.add(body)
        var string = ""
        DOMTreeNode.inorder_tree_traversal(html, &string)
        return "<!DOCTYPE html>\n" + string
    }
}
