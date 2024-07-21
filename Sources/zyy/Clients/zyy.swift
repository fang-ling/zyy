import Foundation
import ArgumentParser

//----------------------------------------------------------------------------//
//                                Shared Constants                            //
//----------------------------------------------------------------------------//
/* Databse filename (not user changeable) */
let ZYY_DB_FILENAME = "zyy.db"
/* Temporary filename */
let ZYY_CONFIG_TEMP = ".zyy.config"
let ZYY_MD_TEMP = ".zyy.md"
/* Database table name */
let ZYY_SET_TBL = "Setting"
let ZYY_SEC_TBL = "Section"
let ZYY_PAGE_TBL = "Page"
/* Database table column name */
/// Setting table
let ZYY_SET_COL_OPT = "option"
let ZYY_SET_COL_VAL = "value"
/// Page table
let ZYY_PAGE_COL_ID = "id"
let ZYY_PAGE_COL_TITLE = "title"
let ZYY_PAGE_COL_LINK = "link"
let ZYY_PAGE_COL_DATE = "date"
let ZYY_PAGE_COL_CONTENT = "content"
let ZYY_PAGE_COL_IS_HIDDEN = "is_hidden"
let ZYY_PAGE_COL_IS_BLOG = "is_blog"
let ZYY_PAGE_COL_DATE_CREATED = "date_created"
let ZYY_PAGE_COL_ARTWORK = "artwork" /* Full link of the artworks, sep by , */
/// Section table
let ZYY_SEC_COL_HEADING = "heading"
let ZYY_SEC_COL_CAPTION = "caption"
let ZYY_SEC_COL_COVER   = "cover"
let ZYY_SEC_COL_HLINK   = "hlink" /* Heading link */
let ZYY_SEC_COL_CLINK   = "clink" /* Caption link */
/* Settings options */
let ZYY_SET_OPT_BUILD_COUNT = "build_count"
let ZYY_SET_OPT_EDITOR = "editor"
let ZYY_SET_OPT_INDEX_UPDATE_TIME = "index_update_time"
/// The title of your website
let ZYY_SET_OPT_TITLE = "title"
/// The URL of your website, must starts with `http://` or `https://`
let ZYY_SET_OPT_URL = "url"
/// Your name
let ZYY_SET_OPT_AUTHOR = "author"
let ZYY_SET_OPT_START_YEAR = "start_year"
let ZYY_SET_OPT_CUSTOM_HEAD = "custom_head"
let ZYY_SET_OPT_CUSTOM_MD   = "custom_markdown"
let ZYY_SET_OPT_CUSTOM_FIELDS = [
  "custom_field_1", "custom_field_2",
  "custom_field_3", "custom_field_4",
  "custom_field_5", "custom_field_6",
  "custom_field_7", "custom_field_8",
]
let ZYY_SET_OPT_CUSTOM_FIELD_URLS = [
  "custom_field_url_1", "custom_field_url_2",
  "custom_field_url_3", "custom_field_url_4",
  "custom_field_url_5", "custom_field_url_6",
  "custom_field_url_7", "custom_field_url_8"
]

@main
struct zyy: ParsableCommand {
  /* Command Line related String constants */
  static let VERSION = "1.0.0"
  static let GITHUB_REPO = "https://github.com/fang-ling/zyy"
  
  static var configuration = CommandConfiguration(
    abstract: "A utility for building personal websites.",
    version: VERSION,
    subcommands: [/*Init.self, Config.self, Build.self,
                  List.self, Add.self, Edit.self, Remove.self*/
      Page.self
                 ]
  )
}
