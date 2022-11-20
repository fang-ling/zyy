//
//  error_handler.swift
//  
//
//  Created by Fang Ling on 2022/11/20.
//

import Foundation

func commandLineError(msg : String) {
    print("Command Line Error:")
    print(msg)
    exit(-1)
}
