//
//  File.swift
//  
//
//  Created by Fang Ling on 2023/5/3.
//

import Foundation

/// Creates tables and writes default values to it.
func create_tables(database : String = ZYY_DB_FILENAME) {
    exec(at: database,
         sql: get_setting_creation_sql() + /// Create Setting table
              get_setting_insert_default_rows_sql() + /// Add default settings
              get_page_creation_sql() /// Create page table
    )
}

/// Returns the sepcific setting
func get_setting(database : String = ZYY_DB_FILENAME,
                 with option : String) -> String? {
    guard
    let result = exec(at: database,
                      sql: get_setting_select_sql(with: option)).first else {
        return nil
    }
    return result[ZYY_SET_COL_VAL]
}
