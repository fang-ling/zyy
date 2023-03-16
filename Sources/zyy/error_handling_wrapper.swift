//
//  error_handling_wrapper.swift
//  
//
//  Created by Fang Ling on 2022/11/20.
//

/* Error-handling wrappers allow us to keep code concise, and after calling one
 * of the following functions, `zyy` will print some messages and exit. */

import Foundation

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
