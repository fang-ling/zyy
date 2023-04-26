//
//  csqlite-tests.swift
//  
//
//  Created by Fang Ling on 2023/4/26.
//

import XCTest
@testable import zyy

final class CSQLiteTests : XCTestCase {
    func test_exec() {
        let result = exec(at: ":memory:", /* In-memory SQLite3 database */
                          sql: """
                               CREATE TABLE IF NOT EXISTS 'users' (
                                   'id' INTEGER PRIMARY KEY,
                                   'name' TEXT,
                                   'email' TEXT NOT NULL UNIQUE
                               );
                               INSERT INTO 'users' ('name', 'email') VALUES
                                   ('Alice', 'alice@test.com');
                               INSERT INTO 'users' ('name', 'email') VALUES
                                   ('Tracy', 'tracy@test.com');
                               SELECT * FROM 'users';
                               """)
        let table = [["id" : "1", "name" : "Alice", "email" : "alice@test.com"],
                     ["id" : "2", "name" : "Tracy", "email" : "tracy@test.com"]]
        XCTAssertEqual(result, table)
    }
}


