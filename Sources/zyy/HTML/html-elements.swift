//
//  html-elements.swift
//
//
//  Created by Fang Ling on 2023/5/26.
//

import cmark_gfm
import Foundation

extension HTML {
  func get_head(title_text : String) -> DOMTreeNode {
    let head = DOMTreeNode(name: "head", attr: [:])
    head.add(DOMTreeNode(name: "meta", attr: ["charset" : "UTF-8"]))
    head.add(DOMTreeNode(
      name: "meta",
      attr: ["name" : "viewport",
             "content" : "width=device-width initial-scale=1"]))
    /* First English, then Traditional Chinese */
    head.add(
      DOMTreeNode(
        name: "link",
        attr: [
          "href" : HTML.FONT_LINK,
          "rel" : "stylesheet",
          "type" : "text/css"
        ]
      )
    )
    head.add(
      DOMTreeNode(
        name: "link",
        attr: [
          "href" : HTML.FONT_TC_LINK,
          "rel" : "stylesheet",
          "type" : "text/css"
        ]
      )
    )
    
    head.add(DOMTreeNode(name: "link",
                         attr: ["href" : HTML.MAIN_STYLE_CSS_FILENAME,
                                "rel" : "stylesheet",
                                "type" : "text/css"]))
    let title = DOMTreeNode(name: "title", attr: [:])
    title.add(title_text)
    head.add(title)
    let custom_head = settings[ZYY_SET_OPT_CUSTOM_HEAD]!
    head.add(custom_head)
    return head
  }
  
  /*
   *  <h1>
   *      <strong>...</strong>
   *  </h1>
   */
  func get_title(title_text : String) -> DOMTreeNode {
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
  func get_head_box() -> DOMTreeNode {
    let fields = get_all_headbox_custom_fields()
    let div = DOMTreeNode(name: "div",
                          attr: ["class" : "purplebox head-box"])
    for i in fields.indices {
      if fields[i].1.isEmpty { /* Plain text node */
        div.add(fields[i].0)
      } else {
        let a = DOMTreeNode(name: "a", attr: ["href" : fields[i].1])
        a.add(fields[i].0)
        div.add(a)
      }
      if (i != fields.count - 1) { /* Add separater */
        div.add("&nbsp;&nbsp;&bull;&nbsp;&nbsp;");
      }
    }
    return div
  }
  
  func get_stack_preview(by section : Section) -> DOMTreeNode {
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
  
  func get_stack_preview_container() -> DOMTreeNode {
    let div = DOMTreeNode(name: "div",
                          attr: ["class" : "stackpreview-container"])
    for section in sections {
      div.add(get_stack_preview(by: section))
    }
    return div
  }
  
  func get_foot_box(date: String) -> DOMTreeNode {
    let author = settings[ZYY_SET_OPT_AUTHOR]!
    let site_url = settings[ZYY_SET_OPT_URL]!
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
  
  func get_footer() -> DOMTreeNode {
    let site_url = settings[ZYY_SET_OPT_URL]!
    let author = settings[ZYY_SET_OPT_AUTHOR]!
    let st_year = settings[ZYY_SET_OPT_START_YEAR]!
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
    let count = settings[ZYY_SET_OPT_BUILD_COUNT]!
    span.add("Build: \(count)")
    div.add(span)
    
    let a3 = DOMTreeNode(
      name: "a",
      attr: ["href" : "https://erikdemaine.org"]
    )
    a3.add("by Prof. Erik Demaine")
    div.add(DOMTreeNode(name: "br", attr: [:]))
    div.add("Blog theme is highly inspired")
    div.add(a3)
    
    let p = DOMTreeNode(name: "p", attr: ["class" : "copyright"])
    p.add("© \(st_year)-\(cr_year) \(author)")
    div.add(p)
    return div
  }
  
  func get_index_body(date: String) -> DOMTreeNode {
    let sitename = settings[ZYY_SET_OPT_TITLE]!
    let body = DOMTreeNode(name: "body", attr: [:])
    body.add(get_title(title_text: sitename))
    body.add(get_head_box())
    body.add(get_stack_preview_container())
    let c_md = settings[ZYY_SET_OPT_CUSTOM_MD]!
    body.add(cmark_markdown_to_html_with_ext(c_md, CMARK_OPT_UNSAFE))
    body.add(get_foot_box(date: date))
    body.add(DOMTreeNode(name: "br", attr: [:]))
    body.add(get_footer())
    let js = DOMTreeNode(name: "script", attr: ["type" : "text/javascript"])
    js.add(STACK_PREVIEW_JS)
    body.add(js)
    return body
  }
  
  /*
   * Main index html:
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
  func get_index(date: String) -> String {
    let sitename = settings[ZYY_SET_OPT_TITLE]!
    let html = DOMTreeNode(name: "html", attr: ["lang" : "en"])
    html.add(get_head(title_text: sitename))
    html.add(get_index_body(date: date))
    var string = ""
    DOMTreeNode.inorder_tree_traversal(html, &string)
    return "<!DOCTYPE html>\n" + string
  }
  
  func get_page(page : Page) -> String {
    var page = page
    let html = DOMTreeNode(name: "html", attr: ["lang" : "en"])
    /* Body */
    let body = DOMTreeNode(name: "body", attr: [:])
    body.add(get_title(title_text: page.title))
    body.add(get_head_box())
    
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
      var lang = lines.removeFirst().lowercased()
      lang.removeFirst(3)
      lines.removeLast()
      var code = ""
      for i in lines {
        code += i + "\n"
      }
      
      var replace = ""
      DOMTreeNode.inorder_tree_traversal_code(
        Code.toHTML(
          code: code,
          language: lang
        ),
        &replace
      )
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
    if page.is_blog == 1 {
      body.add(get_reaction(slug: page.link.components(separatedBy: ".")[0]))
    }
    body.add(get_foot_box(date: page.date))
    body.add(DOMTreeNode(name: "br", attr: [:]))
    body.add(get_footer())
    
    let head = get_head(title_text: page.title)
    if has_math {
      head.add(MATHJAX_JS)
    }
    if has_code {
      head.add(DOMTreeNode(name: "link",
                           attr: ["href" : HTML.CHL_CSS_FILENAME,
                                  "rel" : "stylesheet",
                                  "type" : "text/css"]))
    }
    html.add(head)
    html.add(body)
    var string = ""
    DOMTreeNode.inorder_tree_traversal(html, &string)
    return "<!DOCTYPE html>\n" + string
  }
  
  func get_reaction(slug: String) -> String {
    var js_func = ""
    for i in 1 ... 4 {
      js_func +=
      """
      function zyy_rec_upd\(i)() {
        const str = document.getElementById("zyy-rec-\(i)").innerHTML.split(' ');
        document.getElementById("zyy-rec-\(i)").innerHTML = str[0] + ' ' + (parseInt(str[1]) + 1);
        
        const Http = new XMLHttpRequest();
        Http.open("GET", "https://api.fangl.ing/add?slug=\(slug)&emoji=emoji_\(i)");
        Http.send();
      }
      
      """
    }
    
    let html =
    """
    <style>
    .zyy-reac {
      margin-right: 1em;
      font-size: 12px;
      color: var(--text-color);
      background-color: transparent;
      border: 1px solid #d1d7dd;
      border-radius: 5px;
    }
    .zyy-reac:hover {
      background-color: #ebeef2;
    }
    @media (prefers-color-scheme: dark) {
      .zyy-reac {
        border: 1px solid #31363c;
      }
      .zyy-reac:hover {
        background-color: #22262c;
      }
    }
    </style>
    <script>
    const req = new XMLHttpRequest();
    req.open("GET", "https://api.fangl.ing/get?slug=\(slug)");
    req.send();
    
    req.onreadystatechange=function() {
      if (this.readyState == 4 && this.status == 200) {
        const msg = JSON.parse(req.responseText);
        document.getElementById("zyy-rec-1").innerHTML="❤️ "+msg.emoji_1;
        document.getElementById("zyy-rec-2").innerHTML="👍 "+msg.emoji_2;
        document.getElementById("zyy-rec-3").innerHTML="😅 "+msg.emoji_3;
        document.getElementById("zyy-rec-4").innerHTML="💩 "+msg.emoji_4;
      }
    }
    
    \(js_func)
    </script>
    <div>
      <button id="zyy-rec-1" class="zyy-reac" onclick="zyy_rec_upd1()">❤️ -19358</button>
      <button id="zyy-rec-2" class="zyy-reac" onclick="zyy_rec_upd2()">👍 -19358</button>
      <button id="zyy-rec-3" class="zyy-reac" onclick="zyy_rec_upd3()">😅 -19358</button>
      <button id="zyy-rec-4" class="zyy-reac" onclick="zyy_rec_upd4()">💩 -19358</button>
      <small>
        Reactions powered by <a href="https://vapor.codes" target="_blank">Vapor</a> + <a href="https://sqlite.org" target="_blank">SQLite</a>
      </small>
    </div>
    """
    return html
  }
}
