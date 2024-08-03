//
//  posix-system-call.swift
//  
//
//  Created by Fang Ling on 2023/5/4.
//

import Foundation

func posix_spawn(_ executable_path : String, _ arguments : String...) {
    var pid : pid_t = 0
    /* Force unwrap strdup will fail when it returns NULL if insufficient memory
     * was available, with errno set to indicate the error.
     */
    /* Duplicate executable_path to c_str */
    let path = [executable_path.withCString { c_str in
        strdup(c_str)!
    }]
    /* Transform arguments to array of pointers */
    let args = arguments.map { str in
        str.withCString { c_str in
            return strdup(c_str)!
        }
    }
    /* Free the memory */
    defer {
        (path + args).forEach{ free($0) }
    }
    if posix_spawn(&pid,
                   executable_path,
                   nil,
                   nil,
                   path + args + [nil],
                   environ) < 0 {
        print(String(cString: strerror(errno)))
        fatal_error(.error)
    }
    if waitpid(pid, nil, 0) < 0 {
        print(String(cString: strerror(errno)))
        fatal_error(.error)
    }
}
