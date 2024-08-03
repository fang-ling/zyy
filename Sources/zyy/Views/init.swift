////
////  Init.swift
////
////
////  Created by Fang Ling on 2023/5/6.
////
//
//import Foundation
//import ArgumentParser
//
//extension zyy {
//  struct Init: ParsableCommand {
//    static var configuration = CommandConfiguration(
//      abstract: "Create an empty zyy website"
//    )
//    
//    func run() {
//      /* Prevent user from calling `init` twice */
//      if FileManager.default.fileExists(atPath: ZYY_DB_FILENAME) {
//        fatal_error(.file_already_exists)
//      }
//      
//      let db = DatabaseDriver()
//      
//      /* Create db */
//      db.create_tables()
//      print("Creating \(ZYY_DB_FILENAME)")
//      print("Invoke `zyy config` command to finish setting up your website.")
//    }
//  }
//}
