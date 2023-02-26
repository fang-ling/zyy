//
//  cmark.swift
//  
//
//  Created by Fang Ling on 2022/11/6.
//

import CMark

/*
 *  Convert 'text' (assumed to be a UTF-8 encoded swift string) from CommonMark
 *  Markdown to HTML, producing a null-terminated, UTF-8-encoded c string as an
 *  intermediate result, transforming it to a swift string 'result_str' and free
 *  the intermediate result.
 *
 *  This func is roughly follow the routines in cmark_markdown_to_html() except
 *  that some extensions was enabled.
 */
func cmark_markdown_to_html_with_ext(_ text : String,
                                     _ options : CInt) -> String {
    let parser = cmark_parser_new(options)
    /* Extensions register */
    cmark_gfm_core_extensions_ensure_registered()
    
    /* Add extensions here */
    if let ext = cmark_find_syntax_extension("table") {
        cmark_parser_attach_syntax_extension(parser, ext)
    }
    /* Parse */
    cmark_parser_feed(parser, text, text.utf8.count)
    let doc = cmark_parser_finish(parser)
    /* Render */
    let result = cmark_render_html(doc, options, nil)
    /* Free & return */
    cmark_node_free(doc)
    
    if result == nil {
        fatalError("Error: cmark_render_html()!")
    }
    
    let result_str = String(cString: result!)
    free(result)
    return result_str
}
