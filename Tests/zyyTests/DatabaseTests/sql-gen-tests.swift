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
        
        XCTAssertEqual(table.create_table_sql(columns: columns),
                       """
                       CREATE TABLE IF NOT EXISTS "users" (
                           "id" INTEGER PRIMARY KEY,
                           "name" TEXT,
                           "email" TEXT NOT NULL UNIQUE
                       );
                       """)
    }
    
    func test_insert_into() {
        let row = [("name", "Alice"), ("email", "alice@example.com")]
        let table = Table(name: "users")
        
        let SQL = #"INSERT INTO "users" ("name", "email") VALUES "# +
                  "('Alice', 'alice@example.com');"
        XCTAssertEqual(table.insert_into(row: row), SQL)
    }
    
    func test_select() {
        let table = Table(name: "users")
        
        let SQL = #"SELECT "name", "email" FROM "# +
                  #""users" WHERE ("name" = 'Alice');"#
        XCTAssertEqual(SQL,
                       table.select(columns: ["name", "email"],
                                    where: ("name", "'Alice'")))
    }
    
    func test_select2() {
        let table = Table(name: "users")
        
        let SQL = #"SELECT "name", "email" FROM "users";"#
        XCTAssertEqual(SQL, table.select(columns: ["name", "email"]))
    }
    
    func test_update() {
        let table = Table(name: "users")
        
        let SQL = #"UPDATE "users" SET "email" = 'alice@icloud.com' "# +
                  #"WHERE ("id" = 1);"#
        XCTAssertEqual(SQL,
                       table.update(column_value_pairs: [("email",
                                                          "alice@icloud.com")],
                                    where: ("id", "1")))
    }
    
    func test_delete() {
        let table = Table(name: "users")
        let SQL = #"DELETE FROM "users";"#
        XCTAssertEqual(table.delete(), SQL)
    }
}

