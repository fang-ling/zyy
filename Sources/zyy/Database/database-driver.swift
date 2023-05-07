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
              get_page_creation_sql() + /// Create Page table
              get_section_creation_sql() /// Create Section table
    )
}

//----------------------------------------------------------------------------//
//                          Setting table                                     //
//----------------------------------------------------------------------------//

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

/// Update multiple setting
/// TO-DO: Construct a large SQL instead of consecutively calling set_setting().
func set_settings(database : String = ZYY_DB_FILENAME,
                  option_value_pairs: [(String, String)]) {
    for pair in option_value_pairs {
        set_setting(database: database, with: pair.0, new_value: pair.1)
    }
}

//----------------------------------------------------------------------------//
//                          Section table                                     //
//----------------------------------------------------------------------------//

/// Returns all of the sections
func get_sections(database : String = ZYY_DB_FILENAME) -> [Section] {
    var result = [Section]()
    let delta = exec(at: database, sql: get_section_select_all_sql())
    for i in delta {
        var alpha = Section()
        if let heading = i[ZYY_SEC_COL_HEADING] {
            alpha.heading = heading
        }
        if let caption = i[ZYY_SEC_COL_CAPTION] {
            alpha.caption = caption.from_base64()!
        }
        if let cover = i[ZYY_SEC_COL_COVER] {
            alpha.cover = cover
        }
        if let hlink = i[ZYY_SEC_COL_HLINK] {
            alpha.hlink = hlink
        }
        if let clink = i[ZYY_SEC_COL_CLINK] {
            alpha.clink = clink
        }
        result.append(alpha)
    }
    return result
}

/// Add a new section.
func add_section(database : String = ZYY_DB_FILENAME, section : Section) {
    var section = section
    section.caption = section.caption.to_base64()
    exec(at: database, sql: get_section_insert_sql(section: section))
}

/// Add new sections
func add_sections(database : String = ZYY_DB_FILENAME, sections : [Section]) {
    for section in sections {
        add_section(database : database, section: section)
    }
}

/// Removes all sections
func remove_sections(database : String = ZYY_DB_FILENAME) {
    exec(at: database, sql: get_section_clear_sql())
}
