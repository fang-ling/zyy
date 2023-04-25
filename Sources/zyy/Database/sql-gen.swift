//
//  sql-gen.swift
//  
//
//  Created by Fang Ling on 2023/4/25.
//

import Foundation

/* SQLite keywords in use */
let SQLITE_KEYWORDS = ["CR" : "CREATE", "TB" : "TABLE", "PK" : "PRIMARY KEY",
                       "N"  : "NOT NULL", "U" : "UNIQUE"]

/* SQLite database table */
struct Table {
    var name : String
    var columns : [Column]
}

/* SQLite database table column */
struct Column : Equatable {
    var name : String
    var type : String
    var is_primary_key : Bool
    var is_unique : Bool
    var is_not_null : Bool
    
    init(name : String,
         type : String,
         is_primary_key : Bool = false,
         is_unique : Bool = false,
         is_not_null : Bool = false) {
        self.name = name
        self.type = type
        self.is_primary_key = is_primary_key
        self.is_unique = is_unique
        self.is_not_null = is_not_null
    }
}

//----------------------------------------------------------------------------//
//                                CREATE TABLE                                //
//----------------------------------------------------------------------------//
extension Table {
    func create() -> String {
        var cols = ""
        for column in columns {
            cols += "    '\(column.name)' " + "\(column.type)"
            if column.is_primary_key {
                cols += " " + SQLITE_KEYWORDS["PK"]!
            }
            if column.is_not_null {
                cols += " " + SQLITE_KEYWORDS["N"]!
            }
            if column.is_unique {
                cols += " " + SQLITE_KEYWORDS["U"]!
            }
            cols += (column == columns.last ? "" : ",") + "\n"
        }
        return """
               \(SQLITE_KEYWORDS["CR"]!) \(SQLITE_KEYWORDS["TB"]!) '\(name)' (
               \(cols));
               """
    }
}
