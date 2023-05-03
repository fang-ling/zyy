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
func get_setting_creation_sql() -> String {
    let table = Table(name: ZYY_SET_TBL)
    let columns = [Column(name: ZYY_SET_COL_OPT,
                          type: "TEXT",
                          is_primary_key: true),
                   Column(name: ZYY_SET_COL_VAL, type: "TEXT")]
    return table.create_table_sql(columns: columns)
}

/// Default settings
func get_setting_insert_default_rows_sql() -> String {
    let table = Table(name: ZYY_SET_TBL)
                /// build_count = 0
    var rows = [[(ZYY_SET_COL_OPT, ZYY_SET_OPT_BUILD_COUNT),
                 (ZYY_SET_COL_VAL, "0")],
                /// editor = nano # Every mac's built-in cmdline text editor
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_EDITOR),
                 (ZYY_SET_COL_VAL, "nano")],
                /// index_update_time = `current_time` # non-user visible
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_INDEX_UPDATE_TIME),
                 (ZYY_SET_COL_VAL, get_current_date_string())],
                /// title = ""
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_TITLE),
                 (ZYY_SET_COL_VAL, "")],
                /// url = ""
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_URL),
                 (ZYY_SET_COL_VAL, "")],
                /// author = ""
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_AUTHOR),
                 (ZYY_SET_COL_VAL, "")],
                /// start_year = ""
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_START_YEAR),
                 (ZYY_SET_COL_VAL, "")],
                /// custom_head = ""
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_CUSTOM_HEAD),
                 (ZYY_SET_COL_VAL, "")],
                /// custom_markdown = ""
                [(ZYY_SET_COL_OPT, ZYY_SET_OPT_CUSTOM_MARKDOWN),
                 (ZYY_SET_COL_VAL, "")]]
    for i in ZYY_SET_OPT_CUSTOM_FIELDS + ZYY_SET_OPT_CUSTOM_FIELD_URLS {
        rows.append([(ZYY_SET_COL_OPT, i), (ZYY_SET_COL_VAL, "")])
    }
    var sql = ""
    for i in rows.indices {
        sql += table.insert_into(row: rows[i])
        if i < rows.count - 1 {
            sql += "\n"
        }
    }
    return sql
}

/// Page table:
/// | id | title | link | date | content |
///            \    |           /
///             \   |          /
///             (base64 encoded)
func get_page_creation_sql() -> String {
    let table = Table(name: ZYY_PAGE_TBL)
    let columns = [Column(name: ZYY_PAGE_COL_ID,
                          type: "INTEGER",
                          is_primary_key: true),
                   Column(name: ZYY_PAGE_COL_TITLE, type: "TEXT"),
                   Column(name: ZYY_PAGE_COL_LINK, type: "TEXT"),
                   Column(name: ZYY_PAGE_COL_DATE, type: "TEXT"),
                   Column(name: ZYY_PAGE_COL_CONTENT, type: "TEXT")]
    return table.create_table_sql(columns: columns)
}

//----------------------------------------------------------------------------//
//                                SELECT                                      //
//----------------------------------------------------------------------------//
func get_setting_select_sql(with option : String) -> String {
    let table = Table(name: ZYY_SET_TBL)
    return table.select(columns: [ZYY_SET_COL_VAL],
                        where: (ZYY_SET_COL_OPT, option))
}
