@main
public struct zyy {
    public private(set) var text = "Hello, World!"
    
    private static let VERSION = "0.0.1-pre_alpha"
    private static let WELCOME_MSG =
"""
Usage: zyy <command> [<switches>...]

<Commands>
  init:                 Initialize website database in current directory
  version:              Print version information and exit
"""
    
    public static func main() {
        if CommandLine.arguments.count > 1 {
            if CommandLine.arguments[1] == "init" {
                
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
}
