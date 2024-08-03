//
//  error.swift
//  
//
//  Created by Fang Ling on 2022/11/20.
//

/* Error-handling wrappers allow us to keep code concise, and after calling one
 * of the following functions, `zyy` will print some messages and exit. */

import Foundation

enum FatalError {
    /* File IO */
    case file_already_exists
    case no_such_file
    /* General */
    case error
}

/* Command Line releated error */
func command_line_error(_ msg : String) {
    fatalError("Command Line Error:\n" + msg)
}

/* Database releated error */
func database_error(_ msg: String) {
    fatalError("Database Error:\n" + msg)
}

func error(_ msg : String) {
    fatalError("Error:\n" + msg)
}

func fatal_error(_ error_type : FatalError) {
    switch error_type {
    case .file_already_exists:
        fatalError("A file or folder with the same name already exists")
    case .no_such_file:
        fatalError("No such file or directory")
    default:
        fatalError("Fatal Error")
    }
}
