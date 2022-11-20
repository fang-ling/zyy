//
//  csqlite.swift
//  
//
//  Created by Fang Ling on 2022/11/19.
//

import Foundation
import CSQLite

typealias SQLite3Pointer = OpaquePointer
typealias SQLite3StmtPointer = OpaquePointer

/* Swift wrapper of C library sqlite */
struct SQLite {
    private var db : SQLite3Pointer?
    
    init(at path : String) {
        db = nil
        if sqlite3_open(path, &db) != 0 {
            databaseError(msg: "Can't open database: " +
                               "\(String(cString: sqlite3_errmsg(db)!))")
        }
    }
    
    private func prepare(sql : String) -> SQLite3StmtPointer? {
        var stmt : SQLite3StmtPointer? = nil
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            databaseError(msg: "sqlite3_prepare_v2 failed:\n    \(sql)")
            return nil
        }
        return stmt
    }
    
    @discardableResult
    func exec(sql : String) -> [Dictionary<String, String?>] {
        var result = [Dictionary<String, String>]()
        guard let queryStmt = prepare(sql: sql) else {
            return result
        }
        defer {
            sqlite3_finalize(queryStmt)
        }
        while sqlite3_step(queryStmt) == SQLITE_ROW {
            var dict = Dictionary<String, String>()
            for i in 0 ..< sqlite3_column_count(queryStmt) {
                let col = String(cString: sqlite3_column_name(queryStmt, i))
                if let val = sqlite3_column_text(queryStmt, i) {
                    dict[col] = String(cString: val)
                } else {
                    dict[col] = nil
                }
            }
            result.append(dict)
        }
        return result
    }
    
    func SQLite3_close() {
        sqlite3_close(db)
    }
}
