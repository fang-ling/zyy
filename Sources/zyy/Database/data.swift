//
//  data.swift
//
//
//  Created by Fang Ling on 2022/11/26.
//

import Foundation

/* Section data */
struct Section : Equatable {
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
