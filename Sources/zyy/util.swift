//
//  util.swift
//
//
//  Created by Fang Ling on 2023/2/12.
//

import Foundation

/* Create a new posix process.
 * See: https://stackoverflow.com
 *      /questions/64426373/launch-a-terminal-editor-such-as-vi-or-nano-in-swift
 */
struct PosixProcess {
    let executablePath: String
    let arguments: [String]

    public init(_ executablePath: String, _ arguments: String...) {
        self.executablePath = executablePath
        self.arguments = arguments
    }

    public func spawn() throws {
        var pid: pid_t = 0
        let path = executablePath.withCString(strdup)!
        let args = arguments.map { $0.withCString(strdup)! }
        defer {
            ([path] + args).forEach { free($0) }
        }
        if posix_spawn(&pid, path, nil, nil, [path] + args + [nil], environ) < 0 {
            // throw some error with `errno`
        }
        if waitpid(pid, nil, 0) < 0 {
            // throw some error with `errno`
        }
    }
}
