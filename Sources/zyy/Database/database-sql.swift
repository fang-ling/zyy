//
//  database-sql.swift
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

/// Page table:
/// | id | title | link | date | content |
///            \    |           /
///             \   |          /
///             (base64 encoded)

/// Section table:
/// | heading | caption | cover | hlink | clink |
///                |
///                |
///         (base64 encoded)

//----------------------------------------------------------------------------//
//                                INSERT INTO                                 //
//----------------------------------------------------------------------------//

func get_section_insert_sql(section : Section) -> String {
    let table = Table(name: ZYY_SEC_TBL)
    return table.insert_into(row: [(ZYY_SEC_COL_HEADING, section.heading),
                                   (ZYY_SEC_COL_CAPTION, section.caption),
                                   (ZYY_SEC_COL_COVER, section.cover),
                                   (ZYY_SEC_COL_HLINK, section.hlink),
                                   (ZYY_SEC_COL_CLINK, section.clink)])
}

func get_page_insert_sql(page : Page) -> String {
    let table = Table(name: ZYY_PAGE_TBL)
    return table.insert_into(row: [(ZYY_PAGE_COL_DATE, page.date),
                                   (ZYY_PAGE_COL_LINK, page.link),
                                   (ZYY_PAGE_COL_TITLE, page.title),
                                   (ZYY_PAGE_COL_CONTENT, page.content)])
}

//----------------------------------------------------------------------------//
//                                SELECT                                      //
//----------------------------------------------------------------------------//


func get_section_select_all_sql() -> String {
    let table = Table(name: ZYY_SEC_TBL)
    return table.select(columns: [ZYY_SEC_COL_HEADING, ZYY_SEC_COL_CAPTION,
                                  ZYY_SEC_COL_COVER, ZYY_SEC_COL_HLINK,
                                  ZYY_SEC_COL_CLINK])
}

func get_page_select_sql(columns : [String], by id : Int) -> String {
    let table = Table(name: ZYY_PAGE_TBL)
    return table.select(columns: columns, where: (ZYY_PAGE_COL_ID, "\(id)"));
}

func get_page_select_all_sql(columns : [String]) -> String {
    let table = Table(name: ZYY_PAGE_TBL)
    return table.select(columns: columns)
}

//----------------------------------------------------------------------------//
//                                UPDATE                                      //
//----------------------------------------------------------------------------//
func get_setting_update_sql(with option : String,
                            new_value : String) -> String {
    let table = Table(name: ZYY_SET_TBL)
    return table.update(column_value_pairs: [(ZYY_SET_COL_VAL, new_value)],
                        where: (ZYY_SET_COL_OPT, "'\(option)'"))
}

func get_page_update_sql(page : Page) -> String {
    let table = Table(name: ZYY_PAGE_TBL)
    return table.update(
      column_value_pairs: [(ZYY_PAGE_COL_DATE, page.date),
                           (ZYY_PAGE_COL_LINK, page.link),
                           (ZYY_PAGE_COL_TITLE, page.title),
                           (ZYY_PAGE_COL_CONTENT, page.content)],
      where: (ZYY_PAGE_COL_ID, "\(page.id)")
    )
}

//----------------------------------------------------------------------------//
//                                DELETE                                      //
//----------------------------------------------------------------------------//
func get_section_clear_sql() -> String {
    let table = Table(name: ZYY_SEC_TBL)
    return table.delete()
}

func get_page_delete_sql(id : Int) -> String {
    let table = Table(name: ZYY_PAGE_TBL)
    return table.delete(where: (ZYY_PAGE_COL_ID, "\(id)"))
}
