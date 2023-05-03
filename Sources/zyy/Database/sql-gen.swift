//
//  sql-gen.swift
//  
//
//  Created by Fang Ling on 2023/4/25.
//

import Foundation

/* SQLite keywords in use */
let SQLITE_KEYWORDS = ["CR" : "CREATE", "TB" : "TABLE", "PK" : "PRIMARY KEY",
                       "N"  : "NOT NULL", "U" : "UNIQUE", "INS" : "INSERT",
                       "INTO" : "INTO", "IF" : "IF", "NOT" : "NOT",
                       "EX" : "EXISTS", "VAL" : "VALUES", "SEL" : "SELECT",
                       "FR" : "FROM", "WHERE" : "WHERE", "UPD" : "UPDATE",
                       "SET" : "SET"]

/// From SQLite.org:
/// The SQL standard requires double-quotes around identifiers and single-quotes
/// around string literals.

/* SQLite database table */
/// FAQ from SQLite.org:
///     A column declared INTEGER PRIMARY KEY will autoincrement.
///     For example, suppose you have a table like this:
///
///         CREATE TABLE t1(
///             a INTEGER PRIMARY KEY,
///             b INTEGER
///         );
///
///     With this table, the statement
///
///         INSERT INTO t1 VALUES(NULL,123);
///
///     is logically equivalent to saying:
///
///         INSERT INTO t1 VALUES((SELECT max(a) FROM t1)+1,123);
///
struct Table {
    var name : String
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
    /* Returns table creation SQL */
    func create_table_sql(columns : [Column]) -> String {
        var cols = ""
        for column in columns {
            cols += "    \"\(column.name)\" " + "\(column.type)"
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
        return "\(SQLITE_KEYWORDS["CR"]!) "  +
               "\(SQLITE_KEYWORDS["TB"]!) " +
               "\(SQLITE_KEYWORDS["IF"]!) " +
               "\(SQLITE_KEYWORDS["NOT"]!) " +
               "\(SQLITE_KEYWORDS["EX"]!) " +
               """
               "\(name)" (
               \(cols));
               """
    }
}

//----------------------------------------------------------------------------//
//                                INSERT INTO                                 //
//----------------------------------------------------------------------------//
extension Table {
    func insert_into(row: [(String, String)]) -> String {
        var cols = ""
        var vals = ""
        for i in row {
            cols += "\"\(i.0)\""
            vals += "'\(i.1)'"
            if i != row.last! {
                cols += ", "
                vals += ", "
            }
        }
        return "\(SQLITE_KEYWORDS["INS"]!) " +
               "\(SQLITE_KEYWORDS["INTO"]!) " +
               "\"\(name)\" (" +
               cols +
               ") \(SQLITE_KEYWORDS["VAL"]!) (" +
               vals +
               ");"
    }
}

//----------------------------------------------------------------------------//
//                                UPDATE                                      //
//----------------------------------------------------------------------------//
extension Table {
    func update(column_value_pairs: [(String, String)],
                where : (String, String)) -> String {
        let row_filter = "(\"\(`where`.0)\" = \(`where`.1))"
        var pairs = ""
        for i in column_value_pairs.indices {
            pairs += "\"\(column_value_pairs[i].0)\" = " +
                     "'\(column_value_pairs[i].1)'"
            if i != column_value_pairs.count - 1 {
                pairs += ", "
            }
        }
        return "\(SQLITE_KEYWORDS["UPD"]!) \"\(name)\" " +
               "\(SQLITE_KEYWORDS["SET"]!) " +
               "\(pairs) " +
               "\(SQLITE_KEYWORDS["WHERE"]!) " +
               "\(row_filter);"
    }
}

//----------------------------------------------------------------------------//
//                                SELECT                                      //
//----------------------------------------------------------------------------//
/// Remember to add single-quotes around string literals.
extension Table {
    func select(columns : [String], where : (String, String)) -> String {
        let row_filter = "(\"\(`where`.0)\" = \(`where`.1))"
        var cols = ""
        for column in columns {
            cols += #"""# + column + #"""#
            if column != columns.last {
                cols += ", "
            }
        }
        return "\(SQLITE_KEYWORDS["SEL"]!) " +
               "\(cols) " +
               "\(SQLITE_KEYWORDS["FR"]!) \"\(name)\" " +
               "\(SQLITE_KEYWORDS["WHERE"]!) " +
               "\(row_filter);"
    }
}
