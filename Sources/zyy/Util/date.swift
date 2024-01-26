//
//  date.swift
//
//
//  Created by Fang Ling on 2023/5/24.
//

import Foundation

func get_current_date_string() -> String {
  return date2string(Date())
}

func date2string(_ date : Date) -> String {
  let date_formatter = DateFormatter()
  date_formatter.locale = Locale(identifier: "en_US")
  date_formatter.dateStyle = .long
  return date_formatter.string(from: date)
}

func string2date(_ date_string : String) -> Date {
  let date_formatter = DateFormatter()
  date_formatter.locale = Locale(identifier: "en_US")
  date_formatter.dateStyle = .long
  return date_formatter.date(from: date_string)!
}
