//
//  database.swift
//  
//
//  Created by Fang Ling on 2023/4/26.
//

import Foundation

//----------------------------------------------------------------------------//
//                                CREATE TABLES                               //
//----------------------------------------------------------------------------//

/// Setting table
/// Store the settings in only two rows - something like this:
/// | option 1 | value 1 |
/// | option 2 | value 2 |
/// |   ....   |   ...   |
/// | option N | value N |
func get_setting_sql() -> String {
    let table = Table(name: ZYY_SET_TBL)
    let columns = [Column(name: ZYY_SET_COL_OPT,
                          type: "TEXT",
                          is_primary_key: true),
                   Column(name: ZYY_SET_COL_VAL, type: "TEXT")]
    return table.create_table_sql(columns: columns)
}

/// Default settings:
/// build_count = 0
/// editor = nano # Every mac's built-in cmdline text editor
/// index_update_time = `current_time` # non-user visible
/// others: null
func get_setting_default_rows_sql() -> String {
    let table = Table(name: ZYY_SET_TBL)
    let rows = [[(ZYY_SET_COL_OPT, ZYY_SET_OPT_BUILD_COUNT),
                 (ZYY_SET_COL_VAL, "0")],
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_EDITOR),
                 (ZYY_SET_COL_VAL, "nano")],
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_INDEX_UPDATE_TIME),
                 (ZYY_SET_COL_VAL, get_current_date_string())]]
    var sql = ""
    for i in rows.indices {
        sql += table.insert_into(row: rows[i])
        if i < rows.count - 1 {
            sql += "\n"
        }
    }
    return sql
}

//func create_tables() {
//    
//}
