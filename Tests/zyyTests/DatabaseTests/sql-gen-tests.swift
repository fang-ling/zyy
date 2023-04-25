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
        var table = Table(name: "users")
        table.add_column(name: "id",
                         type: "INTEGER",
                         is_primary_key: true)
        table.add_column(name: "name", type: "TEXT")
        table.add_column(name: "email",
                         type: "TEXT",
                         is_unique: true,
                         is_not_null: true)
        
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

