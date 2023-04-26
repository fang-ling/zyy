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

/// Store the settings in only two rows - something like this:
/// | option 1 | value 1 |
/// | option 2 | value 2 |
/// |   ....   |   ...   |
/// | option N | value N |
func get_setting_sql() -> String {
    let table = Table(name: ZYY_SET_TBL)
    var columns = [Column]()
    columns.append(Column(name: ZYY_SET_COL_OPT,
                          type: "TEXT",
                          is_primary_key: true))
    columns.append(Column(name: ZYY_SET_COL_VAL, type: "TEXT"))
    return table.create_table_sql(columns: columns)
}

func create_tables() {
    
}
