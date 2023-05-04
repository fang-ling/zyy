//
//  database-driver.swift
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
/// Notice that custom_head and custom_html are base64 encoded.
func get_setting(database : String = ZYY_DB_FILENAME,
                 with option : String) -> String? {
    guard
    let result = exec(at: database,
                      sql: get_setting_select_sql(with: option)).first else {
        return nil
    }
    if option == ZYY_SET_OPT_CUSTOM_HEAD || option == ZYY_SET_OPT_CUSTOM_MD {
        return result[ZYY_SET_COL_VAL]?.from_base64()
    }
    return result[ZYY_SET_COL_VAL]
}

/// Update the specific setting.
/// Notice that custom_head and custom_html are base64 encoded.
func set_setting(database : String = ZYY_DB_FILENAME,
                 with option : String,
                 new_value : String) {
    var new_value = new_value
    if option == ZYY_SET_OPT_CUSTOM_HEAD || option == ZYY_SET_OPT_CUSTOM_MD {
        new_value = new_value.to_base64()
    }
    exec(at: database, sql: get_setting_update_sql(with: option,
                                                   new_value: new_value))
}