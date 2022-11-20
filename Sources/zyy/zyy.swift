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
  version:              Print version information and exit
"""
    /* Databse filename(not user changeable) */
    private static let DB_FILENAME = "zyy.db"
    
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
        let SETTINGS_SQL =
                           """
                           CREATE TABLE if not exists Settings(
                                 field    TEXT    PRIMARY KEY    NOT NULL,
                                 value    TEXT
                           );
                           """
        let sqlite = SQLite(at: DB_FILENAME)
        sqlite.exec(sql: SETTINGS_SQL)
        sqlite.SQLite3_close()
    }
}
