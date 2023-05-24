//
//  date.swift
//
//
//  Created by Fang Ling on 2023/5/24.
//

import Foundation

func get_current_date_string() -> String {
    let date_formatter = DateFormatter()
    date_formatter.locale = Locale(identifier: "en_US")
    date_formatter.dateStyle = .long
    return date_formatter.string(from: Date())
}
