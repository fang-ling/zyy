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
        var columns = [Column]()
        columns.append(Column(name: "id",
                              type: "INTEGER",
                              is_primary_key: true))
        columns.append(Column(name: "name", type: "TEXT"))
        columns.append(Column(name: "email",
                              type: "TEXT",
                              is_unique: true,
                              is_not_null: true))
        let table = Table(name: "users", columns: columns)
        
        XCTAssertEqual(table.create(),
                       """
                       CREATE TABLE 'users' (
                           'id' INTEGER PRIMARY KEY,
                           'name' TEXT,
                           'email' TEXT NOT NULL UNIQUE
                       );
                       """)
    }
}

