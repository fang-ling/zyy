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
typealias SQLite3Row = [String : String]

/* Swift wrapper of C library sqlite */
@discardableResult
func exec(at path : String, sql : String) -> [SQLite3Row] {
    var result = [SQLite3Row]()
    /* Open db file */
    var db : SQLite3Pointer? = nil
    /* The sqlite3_open_v2() interface works like sqlite3_open() except that it
     * accepts two additional parameters for additional control over the new
     * database connection.
     *
     * Regardless of the compile-time or start-time settings, URI filenames can
     * be enabled for individual database connections by including the
     * SQLITE_OPEN_URI bit in the set of bits passed as the F parameter to
     * sqlite3_open_v2(N,P,F,V).
     *
     * 'sqlite3_config' is unavailable: Variadic function is unavailable
     */
    let db_flag = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_URI
    if sqlite3_open_v2(path, &db, db_flag, nil) != SQLITE_OK {
        print(String(cString: sqlite3_errmsg(db!)))
        fatal_error(.cannot_open_db)
    }
    /* Prepare (Support multiple queries) */
    var pz_tail : UnsafePointer<CChar>?
    sql.withCString { ptr in
        pz_tail = ptr
    }
    while pz_tail?.pointee != 0 {
        var stmt : SQLite3StmtPointer? = nil
        if sqlite3_prepare_v2(db,
                              pz_tail,
                              -1,
                              &stmt,
                              &pz_tail) != SQLITE_OK {
            print(String(cString: sqlite3_errmsg(db!)))
            fatal_error(.failed_to_compile_sql)
        }
        /* Query using sqlite3_step */
        var code = SQLITE_OK
        repeat {
            code = sqlite3_step(stmt)
            /* Generic error */
            if code == SQLITE_ERROR ||
            /* Abort due to constraint violation */
               code == SQLITE_CONSTRAINT {
                print(String(cString: sqlite3_errmsg(db!)))
                fatal_error(.failed_to_evaluate_sql)
            }
            var row = SQLite3Row()
            for i in 0 ..< sqlite3_column_count(stmt) {
                let col = String(cString: sqlite3_column_name(stmt, i))
                switch sqlite3_column_type(stmt, i) {
                    /* Currently only two type used */
                case SQLITE3_TEXT:
                    row[col] = String(cString: sqlite3_column_text(stmt, i))
                    break
                case SQLITE_INTEGER:
                    row[col] = String(sqlite3_column_int(stmt, i))
                default: break
                }
            }
            if !row.isEmpty {
                result.append(row)
            }
        } while (code != SQLITE_DONE)
        /* SQLITE_DONE means that the statement has finished executing
         * successfully. sqlite3_step() should not be called again.
         */
        sqlite3_finalize(stmt)
    }
    /* Deinit */
    sqlite3_close(db)
    
    return result
}

struct SQLite {
    private var db : SQLite3Pointer?
    
    init(at path : String) {
        db = nil
        if sqlite3_open(path, &db) != SQLITE_OK {
            database_error("Can't open database: " +
                           "\(String(cString: sqlite3_errmsg(db)!))")
        }
    }
    
    private func prepare(sql : String) -> SQLite3StmtPointer? {
        var stmt : SQLite3StmtPointer? = nil
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            database_error("sqlite3_prepare_v2 failed:\n\(sql)")
            return nil
        }
        return stmt
    }
    
    @discardableResult
    func exec(sql : String) -> [[String : String]] {
        var result = [[String : String]]()
        guard let queryStmt = prepare(sql: sql) else {
            return result
        }
        defer {
            sqlite3_finalize(queryStmt)
        }
        while sqlite3_step(queryStmt) == SQLITE_ROW {
            var dict = [String : String]()
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
