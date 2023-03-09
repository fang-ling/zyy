//
//  data.swift
//  
//
//  Created by Fang Ling on 2022/11/26.
//

import Foundation

/* Section data */
struct Section {
    var heading : String
    var caption : String
    var cover : String
    var hlink : String
    var clink : String
    
    init() {
        heading = ""
        caption = ""
        cover = ""
        hlink = ""
        clink = ""
    }
}

/* Page data */
struct Page {
    var title : String
    var content : String
    var link : String
    var date : String
    
    init() {
        title = ""
        content = ""
        link = ""
        date = ""
    }
}
