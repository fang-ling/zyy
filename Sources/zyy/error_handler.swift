//
//  error_handler.swift
//  
//
//  Created by Fang Ling on 2022/11/20.
//

/* Error-handling wrappers allow us to keep code concise, and after calling one
 * of the following functions, `zyy` will print some messages and exit. */

import Foundation

/* Command Line releated error */
func commandLineError(msg : String) {
    print("Command Line Error:")
    print(msg)
    exit(-1)
}

func generalError(msg : String) {
    print("Error:")
    print(msg)
    exit(-1)
}
