import Foundation
import ArgumentParser

extension zyy {
    struct Init : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Initialize website database in current directory."
        )
        
        func run() {
            /* Prevent user from calling `init` twice */
            if FileManager.default.fileExists(atPath: DB_FILENAME) {
                generalError(msg: "Database file: \(DB_FILENAME) existed.")
            }
            /* Create db */
            create_database()
            print("Creating \(DB_FILENAME)")
            print("You may want to invoke `zyy configure` command to " +
                  "finish setting up your website.")
        }
    }
    
    struct Configure : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Set up the website."
        )
        
        func run() {
            /* Interactive settings */
            /* Check if database exists */
            if !FileManager.default.fileExists(atPath: DB_FILENAME) {
                generalError(msg: "Database file: \(DB_FILENAME): " +
                             "No such file or directory")
            }
            print("Hint: Press enter directly to leave it as-is")
            /* Website name*/
            var site_name = get_setting(field: DB_SETTING_FIELD_SITENAME)
            print("What's the name of your site[\(site_name)]: ")
            site_name = readLine() ?? site_name /* May be unnecessary */
            if site_name != "" { /* User input something */
                setSetting(field: DB_SETTING_FIELD_SITENAME,
                           value: site_name)
            }
            /* Site url */
            var site_url = get_setting(field: DB_SETTING_FIELD_SITEURL)
            print("What's the URL of your site[\(site_url)]: ")
            site_url = readLine() ?? site_url /* May be unnecessary */
            if site_url != "" {
                setSetting(field: DB_SETTING_FIELD_SITEURL, value: site_url)
            }
            /* Head box custom fields */
            for i in 0 ..< SITE_MAX_CUSTOM_FIELDS {
                var c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i])
                print("What's the \(getOrdinalNumbers(i+1)) custom field " +
                      "in head box of the index page[\(c)]: ")
                c = readLine() ?? c
                if c != "" {
                    setSetting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i],
                               value: c)
                }
                c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i])
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
            var author = get_setting(field: DB_SETTING_FIELD_AUTHOR)
            print("What's your name[\(author)]: ")
            author = readLine() ?? author /* May be unnecessary */
            if author != "" {
                setSetting(field: DB_SETTING_FIELD_AUTHOR, value: author)
            }
            /* Start year */
            var st_year = get_setting(field: DB_SETTING_FIELD_START_YEAR)
            print("Start year of the website[\(st_year)]: ")
            st_year = readLine() ?? st_year
            if st_year != "" {
                setSetting(field: DB_SETTING_FIELD_START_YEAR,
                           value: st_year)
            }
        }
    }
    
    struct Generate : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate static files."
        )
        
        func run() {
            HTML.write_to_file()
        }
    }
    
    struct Update : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Update database file."
        )
        
        func run() {
            create_database()
        }
    }
}

extension zyy {
    struct SectionCommand : ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "section",
            abstract: "Create, delete and work on sections.",
            subcommands: [Add.self, Edit.self, Remove.self, List.self]
        )
    }
}

extension zyy.SectionCommand {
    struct Add : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Add a section with specific name."
        )
        
        @Argument(help: "The name of the new section.")
        var name : String
        
        func run() {
            var sec = zyy.get_section(heading: name)
            if sec.heading == name {
                commandLineError(msg: "Already existed:\n" + name)
            }
            sec.heading = name
            print("Caption:")
            sec.caption = readLine() ?? ""
            print("Cover:")
            sec.cover = readLine() ?? ""
            print("Heading link:")
            sec.hlink = readLine() ?? ""
            print("Cover link:")
            sec.clink = readLine() ?? ""
            zyy.set_section(sec)
        }
    }
    
    struct Edit : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Modify the specific section."
        )
        
        @Argument(help: "The name of the section.")
        var name : String
        
        func run() {
            var sec = zyy.get_section(heading: name)
            if sec.heading != name {
                commandLineError(msg: "No such section:\n" + name)
            }
            print("Caption[\(sec.caption)]:")
            sec.caption = readLine() ?? ""
            print("Cover[\(sec.cover)]:")
            sec.cover = readLine() ?? ""
            print("Heading link[\(sec.hlink)]:")
            sec.hlink = readLine() ?? ""
            print("Cover link[\(sec.clink)]:")
            sec.clink = readLine() ?? ""
            zyy.set_section(sec)
        }
    }
    
    struct Remove : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Remove the section."
        )
        
        @Argument(help: "The name of the section.")
        var name : String
        
        func run() {
            let sec = zyy.get_section(heading: name)
            if sec.heading != name {
                commandLineError(msg: "No such section:\n" + name)
            }
            zyy.remove_section(heading: name)
        }
    }
    
    struct List : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "List all sections."
        )
        
        func run() {
            for i in zyy.list_sections() {
                print(i.heading)
            }
        }
    }
}

extension zyy {
    struct PageCommand : ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "page",
            abstract: "Create, delete and work on pages.",
            subcommands: [Add.self, Edit.self, Remove.self, List.self]
        )
    }
}

extension zyy.PageCommand {
    struct List : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "List all pages."
        )
        
        func run() {
            for i in zyy.list_pages() {
                print(i.title)
            }
        }
    }
    
    struct Add : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Add new page"
        )
        
        @Argument(help: "The title of the new page.")
        var title : String
        
        func run() {
            var page = zyy.get_page(by: title)
            if page.title == title {
                commandLineError(msg: "Already existed:\n" + title)
            }
            page.title = title
            page.content = ""
            print("Content (End with '###***%%%'):")
            var delta = ""
            while true {
                delta = readLine()!
                if delta == "###***%%%" {
                    break
                }
                page.content += delta + "\n"
            }
            print("Website link (relative):")
            page.link = readLine() ?? ""
            zyy.set_page(page)
        }
    }
    
    struct Edit : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Modify the page."
        )
        
        @Argument(help: "The title of the page.")
        var title : String
        
        func run() {
            var page = zyy.get_page(by: title)
            if page.title != title {
                commandLineError(msg: "No such section:\n" + title)
            }
            print("Hint: Press enter directly to leave it as-is")
            print("Title[\(page.title)]:")
            let title = readLine() ?? ""
            if title != "" {
                page.title = title
            }
            do {
                try page.content.write(toFile: ".PAGE",
                                       atomically: true,
                                       encoding: .utf8)
                //TO-DO: support different editors
                try PosixProcess("/usr/local/bin/emacs", ".PAGE").spawn()
                page.content = try String(contentsOfFile: ".PAGE",
                                          encoding: .utf8)
                try PosixProcess("/bin/rm", ".PAGE").spawn()
            } catch {
                commandLineError(msg: error.localizedDescription)
            }
            print("Website link (relative)[\(page.link)]:")
            let link = readLine() ?? ""
            if link != "" {
                page.link = link
            }
            zyy.set_page(page)
        }
    }
    
    struct Remove : ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Remove the page."
        )
        
        @Argument(help: "The title of the page.")
        var title : String
        
        func run() {
            let page = zyy.get_page(by: title)
            if page.title != title {
                commandLineError(msg: "No such page:\n" + title)
            }
            zyy.remove_page(title: title)
        }
    }
}

@main
struct zyy : ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for building personal websites.",
        version: VERSION,
        subcommands: [Init.self, Configure.self, Generate.self, Update.self,
                      SectionCommand.self,
                      PageCommand.self]
    )
    
    /* Command Line related String constants */
    public static let VERSION = "0.0.1"
    public static let GITHUB_REPO = "https://github.com/fang-ling/zyy"
    /* Databse filename(not user changeable) */
    private static let DB_FILENAME = "zyy.db"
    /* Database table name */
    private static let DB_SETTING_TABLE_NAME = "Setting"
    private static let DB_SECTION_TABLE_NAME = "Section"
    private static let DB_PAGE_TABLE_NAME = "Page"
    /* Database table column name */
    private static let DB_SETTING_TABLE_COL_FIELD   = "field"
    private static let DB_SETTING_TABLE_COL_VALUE   = "value"
    private static let DB_SECTION_TABLE_COL_HEADING = "heading"
    private static let DB_SECTION_TABLE_COL_CAPTION = "caption"
    private static let DB_SECTION_TABLE_COL_COVER   = "cover"
    private static let DB_SECTION_TABLE_COL_HLINK   = "hlink" /* Heading link */
    private static let DB_SECTION_TABLE_COL_CLINK   = "clink" /* Caption link */
    private static let DB_PAGE_TABLE_COL_TITLE = "title"
    private static let DB_PAGE_TABLE_COL_CONTENT = "content"
    private static let DB_PAGE_TABLE_COL_LINK = "link"
    /* Setting table field names */
    static let DB_SETTING_FIELD_SITENAME          = "sitename"
    static let DB_SETTING_FIELD_SITEURL           = "site_url"
    /* Don't forget to change these two when `SITE_MAX_CUSTOM_FIELDS` changed */
    private static let DB_SETTING_FIELD_CUSTOM_FIELDS     = ["cf1", "cf2",
                                                             "cf3", "cf4",
                                                             "cf5", "cf6",
                                                             "cf7", "cf8"]
    private static let DB_SETTING_FIELD_CUSTOM_FIELD_URLS = ["cf1u", "cf2u",
                                                             "cf3u", "cf4u",
                                                             "cf5u", "cf6u",
                                                             "cf7u", "cf8u"]
    static let DB_SETTING_FIELD_AUTHOR            = "author"
    static let DB_SETTING_FIELD_START_YEAR        = "st_year"
    
    /* Maximum custom fields in head box */
    private static let SITE_MAX_CUSTOM_FIELDS = 8
    
    private static func create_database() {
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
        /* Page table */
            SQL = """
                  CREATE TABLE if not exists \(DB_PAGE_TABLE_NAME)(
                      \(DB_PAGE_TABLE_COL_TITLE) TEXT PRIMARY KEY NOT NULL,
                      \(DB_PAGE_TABLE_COL_CONTENT) TEXT,
                      \(DB_PAGE_TABLE_COL_LINK)   TEXT
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
    static func get_setting(field : String) -> String {
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
    private static func set_section(_ s : Section) {
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
    private static func get_section(heading : String) -> Section {
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
    private static func remove_section(heading : String) {
        let SQL = """
                  DELETE FROM \(DB_SECTION_TABLE_NAME)
                  WHERE \(DB_SECTION_TABLE_COL_HEADING) = '\(heading)';
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* List sections */
    static func list_sections() -> [Section] {
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
    
    /* Search for page with specific title */
    private static func get_page(by title : String) -> Page {
        let title = title.to_base64()
        let SQL = """
                  SELECT * FROM \(DB_PAGE_TABLE_NAME)
                  WHERE \(DB_PAGE_TABLE_COL_TITLE) = '\(title)';
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var value = Page()
        if let row = result.first {
            if let val = row[DB_PAGE_TABLE_COL_TITLE] {
                if let v = val { value.title = v.from_base64()! }
            }
            if let val = row[DB_PAGE_TABLE_COL_CONTENT] {
                if let v = val { value.content = v.from_base64()! }
            }
            if let val = row[DB_PAGE_TABLE_COL_LINK] {
                if let v = val { value.link = v.from_base64()! }
            }
        }
        sqlite.SQLite3_close()
        return value
    }
    
    /* Modify or insert a new page */
    private static func set_page(_ p : Page) {
        var SQL = """
                  INSERT OR IGNORE INTO \(DB_PAGE_TABLE_NAME)
                  (\(DB_PAGE_TABLE_COL_TITLE),
                   \(DB_PAGE_TABLE_COL_CONTENT),
                   \(DB_PAGE_TABLE_COL_LINK))
                  VALUES(
                      '\(p.title.to_base64())',
                      '\(p.content.to_base64())',
                      '\(p.link.to_base64())'
                  );
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
            SQL = """
                  UPDATE \(DB_PAGE_TABLE_NAME)
                  SET \(DB_PAGE_TABLE_COL_TITLE) = '\(p.title.to_base64())',
                      \(DB_PAGE_TABLE_COL_CONTENT) = '\(p.content.to_base64())',
                      \(DB_PAGE_TABLE_COL_LINK) = '\(p.link.to_base64())'
                  WHERE \(DB_PAGE_TABLE_COL_TITLE) = '\(p.title.to_base64())';
                  """
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* Remove a page */
    private static func remove_page(title : String) {
        let SQL = """
                  DELETE FROM \(DB_PAGE_TABLE_NAME)
                  WHERE \(DB_PAGE_TABLE_COL_TITLE) = '\(title.to_base64())';
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SQL)
        sqlite.SQLite3_close()
    }
    
    /* List all pages */
    static func list_pages() -> [Page] {
        let SQL = """
                  SELECT * FROM \(DB_PAGE_TABLE_NAME);
                  """
        let sqlite = SQLite(at: DB_FILENAME)
        let result = sqlite.exec(sql: SQL)
        var ret = [Page]()
        for row in result {
            var value = Page()
            if let val = row[DB_PAGE_TABLE_COL_TITLE] {
                if let v = val { value.title = v.from_base64()! }
            }
            if let val = row[DB_PAGE_TABLE_COL_CONTENT] {
                if let v = val { value.content = v.from_base64()! }
            }
            if let val = row[DB_PAGE_TABLE_COL_LINK] {
                if let v = val { value.link = v.from_base64()! }
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
            var c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELDS[i])
            if c != "" {
                res[0].append(c)
            }
            
            c = get_setting(field: DB_SETTING_FIELD_CUSTOM_FIELD_URLS[i])
            if c != "" {
                res[1].append(c)
            } else { /* Required for matching fields and urls */
                res[1].append("")
            }
        }
        return res
    }
}
