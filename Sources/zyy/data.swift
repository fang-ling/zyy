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
    
    init(heading: String, caption: String, cover: String,
         hlink: String, clink: String) {
        self.heading = heading
        self.caption = caption
        self.cover = cover
        self.hlink = hlink
        self.clink = clink
    }
    
    init() {
        heading = ""
        caption = ""
        cover = ""
        hlink = ""
        clink = ""
    }
}
