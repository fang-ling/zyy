//
//  sql-gen-tests.swift
//  
//
//  Created by Fang Ling on 2023/4/25.
//

import XCTest
@testable import zyy

final class SQLGenTests: XCTestCase {
    func test_create() {
        let table = Table(name: "users")
        var columns = [Column]()
        columns.append(Column(name: "id",
                              type: "INTEGER",
                              is_primary_key: true))
        columns.append(Column(name: "name", type: "TEXT"))
        columns.append(Column(name: "email",
                              type: "TEXT",
                              is_unique: true,
                              is_not_null: true))
        
        XCTAssertEqual(table.create(columns: columns),
                       """
                       CREATE TABLE IF NOT EXISTS 'users' (
                           'id' INTEGER PRIMARY KEY,
                           'name' TEXT,
                           'email' TEXT NOT NULL UNIQUE
                       );
                       """)
    }
    
    func test_insert_into() {
        var columns = [Column]()
        columns.append(Column(name: "id",
                              type: "INTEGER",
                              is_primary_key: true))
        columns.append(Column(name: "name", type: "TEXT"))
        columns.append(Column(name: "email",
                              type: "TEXT",
                              is_unique: true,
                              is_not_null: true))
        columns.removeFirst()
        let table = Table(name: "users")
        let values = ["Alice", "alice@example.com"]
        
        let SQL = "INSERT INTO 'users' ('name', 'email') VALUES " +
                  "('Alice', 'alice@example.com');"
        XCTAssertEqual(table.insert_into(columns: columns, values: values),
                       SQL)
    }
}

