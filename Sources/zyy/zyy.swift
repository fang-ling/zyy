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
  generate:             Generate static files
  version:              Print version information and exit

Subcommands:

  section:              Create, delete and work on sections

    Usage: zyy section <subcommand> <name>

    <subcommand>

      add:              Add a section named <name>
      edit:             Modify the section named <name>
      remove:           Remove the section named <name>
      list:             List all sections
"""
    /* Databse filename(not user changeable) */
    private static let DB_FILENAME = "zyy.db"
    /* Database table name */
    private static let DB_SETTING_TABLE_NAME = "Setting"
    private static let DB_SECTION_TABLE_NAME = "Section"
    /* Database table column name */
    private static let DB_SETTING_TABLE_COL_FIELD   = "field"
    private static let DB_SETTING_TABLE_COL_VALUE   = "value"
    private static let DB_SECTION_TABLE_COL_HEADING = "heading"
    private static let DB_SECTION_TABLE_COL_CAPTION = "caption"
    private static let DB_SECTION_TABLE_COL_COVER   = "cover"
    private static let DB_SECTION_TABLE_COL_HLINK   = "hlink" /* Heading link */
    private static let DB_SECTION_TABLE_COL_CLINK   = "clink" /* Caption link */
    /* Setting table field names */
    private static let DB_SETTING_FIELD_SITENAME          = "sitename"
    private static let DB_SETTING_FIELD_SITEURL           = "site_url"
    /* Don't forget to change these two when `SITE_MAX_CUSTOM_FIELDS` changed */
    private static let DB_SETTING_FIELD_CUSTOM_FIELDS     = ["cf1", "cf2",
                                                             "cf3", "cf4",
                                                             "cf5", "cf6",
                                                             "cf7", "cf8"]
    private static let DB_SETTING_FIELD_CUSTOM_FIELD_URLS = ["cf1u", "cf2u",
                                                             "cf3u", "cf4u",
                                                             "cf5u", "cf6u",
                                                             "cf7u", "cf8u"]
    private static let DB_SETTING_FIELD_AUTHOR            = "author"
    private static let DB_SETTING_FIELD_START_YEAR        = "st_year"
    
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
                /* Author */
                var author = getSetting(field: DB_SETTING_FIELD_AUTHOR)
                print("What's your name[\(author)]: ")
                author = readLine() ?? author /* May be unnecessary */
                if author != "" {
                    setSetting(field: DB_SETTING_FIELD_AUTHOR, value: author)
                }
                /* Start year */
                var st_year = getSetting(field: DB_SETTING_FIELD_START_YEAR)
                print("Start year of the website[\(st_year)]: ")
                st_year = readLine() ?? st_year
                if st_year != "" {
                    setSetting(field: DB_SETTING_FIELD_START_YEAR,
                               value: st_year)
                }
            } else if CommandLine.arguments[1] == "section" {
                if CommandLine.arguments.count < 4 &&
                   CommandLine.arguments[2] != "list" {
                    commandLineError(msg: "Missing argument near:\n" +
                                          CommandLine.arguments.last!)
                }
                if CommandLine.arguments[2] == "list" {
                    for i in listSection() {
                        print(i.heading)
                    }
                } else if CommandLine.arguments[2] == "add" {
                    var sec = getSection(heading: CommandLine.arguments[3])
                    if sec.heading == CommandLine.arguments[3] {
                        commandLineError(msg: "Already existed:\n" +
                                              CommandLine.arguments[3])
                    }
                    sec.heading = CommandLine.arguments[3]
                    print("Caption:")
                    sec.caption = readLine() ?? ""
                    print("Cover:")
                    sec.cover = readLine() ?? ""
                    print("Heading link:")
                    sec.hlink = readLine() ?? ""
                    print("Cover link:")
                    sec.clink = readLine() ?? ""
                    setSection(sec)
                } else if CommandLine.arguments[2] == "remove" {
                    let sec = getSection(heading: CommandLine.arguments[3])
                    if sec.heading != CommandLine.arguments[3] {
                        commandLineError(msg: "No such section:\n" +
                                              CommandLine.arguments[3])
                    }
                    removeSection(heading: CommandLine.arguments[3])
                } else if CommandLine.arguments[2] == "edit" {
                    var sec = getSection(heading: CommandLine.arguments[3])
                    if sec.heading != CommandLine.arguments[3] {
                        commandLineError(msg: "No such section:\n" +
                                              CommandLine.arguments[3])
                    }
                    print("Caption[\(sec.caption)]:")
                    sec.caption = readLine() ?? ""
                    print("Cover[\(sec.cover)]:")
                    sec.cover = readLine() ?? ""
                    print("Heading link[\(sec.hlink)]:")
                    sec.hlink = readLine() ?? ""
                    print("Cover link[\(sec.clink)]:")
                    sec.clink = readLine() ?? ""
                    setSection(sec)
                } else {
                    commandLineError(msg: "Unsupported command:\n" +
                                          CommandLine.arguments[2])
                }
            } else if CommandLine.arguments[1] == "generate" {
                
            } else if CommandLine.arguments[1] == "version" {
                print(VERSION)
            } else {
                commandLineError(msg: "Unsupported command:\n" +
                                      CommandLine.arguments[1])
            }
        } else {
            print(WELCOME_MSG)
        }
    }
    
    private static func createDatabase() {
        /* Setting table */
        var SQL = """
                  CREATE TABLE if not exists \(DB_SETTING_TABLE_NAME)(
                      \(DB_SETTING_TABLE_COL_FIELD) TEXT PRIMARY KEY NOT NULL,
                      \(DB_SETTING_TABLE_COL_VALUE) TEXT
                  );
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
        /* Section table */
            SQL = """
                  CREATE TABLE if not exists \(DB_SECTION_TABLE_NAME)(
                      \(DB_SECTION_TABLE_COL_HEADING) TEXT PRIMARY KEY NOT NULL,
                      \(DB_SECTION_TABLE_COL_CAPTION) TEXT,
                      \(DB_SECTION_TABLE_COL_COVER)   TEXT,
                      \(DB_SECTION_TABLE_COL_HLINK)   TEXT,
                      \(DB_SECTION_TABLE_COL_CLINK)   TEXT
                  );
                  """
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
                  INSERT OR IGNORE INTO \(DB_SETTING_TABLE_NAME)
                  (\(DB_SETTING_TABLE_COL_FIELD), \(DB_SETTING_TABLE_COL_VALUE))
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
                  WHERE \(DB_SETTING_TABLE_COL_FIELD) = '\(field)';
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
    
    /* Add a new section in table, and will replace the old one if exists. */
    /* Use the `INSERT OR IGNORE` followed by an `UPDATE`. */
    private static func setSection(_ s : Section) {
        var SQL = """
                  INSERT OR IGNORE INTO \(DB_SECTION_TABLE_NAME)
                  (\(DB_SECTION_TABLE_COL_HEADING),
                   \(DB_SECTION_TABLE_COL_CAPTION),
                   \(DB_SECTION_TABLE_COL_COVER),
                   \(DB_SECTION_TABLE_COL_HLINK),
                   \(DB_SECTION_TABLE_COL_CLINK))
                  VALUES(
                      '\(s.heading)', '\(s.caption)',
                      '\(s.cover)', '\(s.hlink)', '\(s.clink)'
                  );
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(DB_SECTION_TABLE_NAME)
                  SET \(DB_SECTION_TABLE_COL_HEADING) = '\(s.heading)',
                      \(DB_SECTION_TABLE_COL_CAPTION) = '\(s.caption)',
                      \(DB_SECTION_TABLE_COL_COVER) = '\(s.cover)',
                      \(DB_SECTION_TABLE_COL_HLINK) = '\(s.hlink)',
                      \(DB_SECTION_TABLE_COL_CLINK) = '\(s.clink)'
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(s.heading)';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Get a section value from given section `heading`.
     */
    private static func getSection(heading : String) -> Section {
        let SQL = """
                  SELECT * FROM \(DB_SECTION_TABLE_NAME)
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(heading)';
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = Section()
        /* Already find result in SQL, so result.count should be either 0 or 1*/
        if let row = result.first {
            /* Will result a String?? (nasty) */
            if let val = row[DB_SECTION_TABLE_COL_HEADING] {
                if let v = val { value.heading = v }
            }
            if let val = row[DB_SECTION_TABLE_COL_CAPTION] {
                if let v = val { value.caption = v }
            }
            if let val = row[DB_SECTION_TABLE_COL_COVER] {
                if let v = val { value.cover = v }
            }
            if let val = row[DB_SECTION_TABLE_COL_HLINK] {
                if let v = val { value.hlink = v }
            }
            if let val = row[DB_SECTION_TABLE_COL_CLINK] {
                if let v = val { value.clink = v }
            }
        }
        sqlite.SQLite3_close()
        return value
    }
    
    /* Remove a section */
    private static func removeSection(heading : String) {
        let SQL = """
                  DELETE FROM \(DB_SECTION_TABLE_NAME)
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(heading)';
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* List sections */
    private static func listSection() -> [Section] {
        let SQL = """
                  SELECT * FROM \(DB_SECTION_TABLE_NAME);
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var ret = [Section]()
        for i in result {
            var value = Section()
            /* Will result a String?? (nasty) */
            if let val = i[DB_SECTION_TABLE_COL_HEADING] {
                if let v = val { value.heading = v }
            }
            if let val = i[DB_SECTION_TABLE_COL_CAPTION] {
                if let v = val { value.caption = v }
            }
            if let val = i[DB_SECTION_TABLE_COL_COVER] {
                if let v = val { value.cover = v }
            }
            if let val = i[DB_SECTION_TABLE_COL_HLINK] {
                if let v = val { value.hlink = v }
            }
            if let val = i[DB_SECTION_TABLE_COL_CLINK] {
                if let v = val { value.clink = v }
            }
            ret.append(value)
        }
        sqlite.SQLite3_close()
        return ret
    }
    
    /* Maybe there exists a better way to do this. :< */
    /* Return `i-st`, `i-nd`, `i-rd` or `i-th`, i is a number. */
    private static func getOrdinalNumbers(_ i : Int) -> String {
        if i % 10 == 1 {
            return "\(i)-st"
        } else if i % 10 == 2 {
            return "\(i)-nd"
        } else if i % 10 == 3 {
            return "\(i)-rd"
        } else {
            return "\(i)-th"
        }
    }
    
    public static func getAllHeadBoxCustomFields() -> [[String]] {
        var res = [[String]](repeating: [String](), count: 2)
        /* Head box custom fields */
        for i in 0 ..< SITE_MAX_CUSTOM_FIELDS {
            var c = getSetting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i])
            if c != "" {
                res[0].append(c)
            }
            
            c = getSetting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i])
            if c != "" {
                res[1].append(c)
            }
        }
        return res
    }
}
