import Foundation

@main
public struct zyy {
    public private(set) var text = "Hello, World!"
    
    /* Command Line related String constants */
    private static let VERSION = "0.0.1-pre_alpha"
    private static let WELCOME_MSG =
"""
Usage: zyy <command> [<switches>...]

<Commands>
  init:                 Initialize website database in current directory
  configure:            Set up the website
  version:              Print version information and exit
"""
    /* Databse filename(not user changeable) */
    private static let DB_FILENAME = "zyy.db"
    /* Database table name */
    private static let DB_SETTING_TABLE_NAME = "Setting"
    /* Database table column name */
    private static let DB_SETTING_TABLE_COL_FIELD = "field"
    private static let DB_SETTING_TABLE_COL_VALUE = "value"
    /* Setting table field names */
    private static let DB_SETTING_FIELD_SITENAME = "sitename"
    private static let DB_SETTING_FIELD_SITEURL = "site_url"
    /* Don't forget to change these two when `SITE_MAX_CUSTOM_FIELDS` changed */
    private static let DB_SETTING_FIELD_CUSTOM_FIELDS = ["cf1", "cf2", "cf3",
                                                         "cf4", "cf5", "cf6",
                                                         "cf7", "cf8"]
    private static let DB_SETTING_FIELD_CUSTOM_FIELD_URLS = ["cf1u", "cf2u",
                                                             "cf3u", "cf4u",
                                                             "cf5u", "cf6u",
                                                             "cf7u", "cf8u"]
    
    /* Maximum custom fields in head box */
    private static let SITE_MAX_CUSTOM_FIELDS = 8
    
    public static func main() {
        if CommandLine.arguments.count > 1 {
            if CommandLine.arguments[1] == "init" {
                /* Prevent user from calling `init` twice */
                if FileManager.default.fileExists(atPath: DB_FILENAME) {
                    generalError(msg: "Database file: \(DB_FILENAME) existed")
                }
                /* Create db */
                createDatabase()
                print("Creating \(DB_FILENAME)")
                print("You may want to invoke `zyy configure` command to " +
                      "finish setting up your website")
            } else if CommandLine.arguments[1] == "configure" {
                /* Interactive settings */
                /* Check if database exists */
                if !FileManager.default.fileExists(atPath: DB_FILENAME) {
                    generalError(msg: "Database file: \(DB_FILENAME): " +
                                      "No such file or directory")
                }
                print("Hint: Press enter directly to leave it as-is")
                /* Website name*/
                var site_name = getSetting(field: DB_SETTING_FIELD_SITENAME)
                print("What's the name of your site[\(site_name)]: ")
                site_name = readLine() ?? site_name /* May be unnecessary */
                if site_name != "" { /* User input something */
                    setSetting(field: DB_SETTING_FIELD_SITENAME,
                               value: site_name)
                }
                /* Site url */
                var site_url = getSetting(field: DB_SETTING_FIELD_SITEURL)
                print("What's the URL of your site[\(site_url)]: ")
                site_url = readLine() ?? site_url /* May be unnecessary */
                if site_url != "" {
                    setSetting(field: DB_SETTING_FIELD_SITEURL, value: site_url)
                }
                /* Head box custom fields */
                for i in 0 ..< SITE_MAX_CUSTOM_FIELDS {
                    var c = getSetting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i])
                    print("What's the \(getOrdinalNumbers(i+1)) custom field " +
                          "in head box of the index page[\(c)]: ")
                    c = readLine() ?? c
                    if c != "" {
                        setSetting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i],
                                   value: c)
                    }
                    c = getSetting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i])
                    print("Does it have a link[\(c)]: ")
                    c = readLine() ?? c
                    if c != "" {
                        setSetting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i],
                                   value: c)
                    }
                    print("Need more?[y / n (Default is no)]")
                    if let ans = readLine() {
                        if ans.count == 0 || ans.starts(with: "n") {
                            break
                        }
                    }
                }
                
            } else if CommandLine.arguments[1] == "version" {
                print(VERSION)
            } else {
                commandLineError(msg: "Unsupported command:\n" +
                                      "\(CommandLine.arguments[1])")
            }
        } else {
            print(WELCOME_MSG)
        }
    }
    
    private static func createDatabase() {
        let SQL = """
                  CREATE TABLE if not exists \(DB_SETTING_TABLE_NAME)(
                      \(DB_SETTING_TABLE_COL_FIELD) TEXT PRIMARY KEY NOT NULL,
                      \(DB_SETTING_TABLE_COL_VALUE) TEXT
                  );
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Add a new setting in table, and will replace the old one if exists. */
    private static func setSetting(field : String, value : String) {
        /* See: https://stackoverflow.com
         *      /questions/3634984/insert-if-not-exists-else-update
         * Use the `INSERT OR IGNORE` followed by an `UPDATE`.
         */
        var SQL = """
                  INSERT OR IGNORE INTO \(DB_SETTING_TABLE_NAME) (field, value)
                  VALUES(
                      '\(field)', '\(value)'
                  );
                  """
                  
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(DB_SETTING_TABLE_NAME)
                  SET \(DB_SETTING_TABLE_COL_VALUE) = '\(value)'
                  WHERE \(DB_SETTING_TABLE_COL_FIELD) = '\(field)';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Get a setting value from given `field`. */
    private static func getSetting(field : String) -> String {
        let SQL = """
                  SELECT * FROM \(DB_SETTING_TABLE_NAME)
                  WHERE field = '\(field)';
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = ""
        /* Already find result in SQL, so result.count should be either 0 or 1*/
        if let row = result.first {
            /* Will result a String?? (nasty) */
            if let val = row[DB_SETTING_TABLE_COL_VALUE] {
                if let v = val {
                    value = v
                }
            }
        }
        sqlite.SQLite3_close()
        return value
    }
    
    /* Maybe there exists a better way to do this. :< */
    /* Return `i-st`, `i-nd`, `i-rd` or `i-th`, i is a number. */
    private static func getOrdinalNumbers(_ i : Int) -> String {
        if i == 1 {
            return "1-st"
        } else if i == 2 {
            return "2-nd"
        } else if i == 3 {
            return "3-rd"
        } else {
            return "\(i)-th"
        }
    }
}
