//
//  DatabaseHelper.swift
//  MinimalistItem
//
//  Created by David Li on 2024-05-26.
//

import Foundation
import SQLite3

class DatabaseHelper {
    static let shared = DatabaseHelper()
    
    private let dbPath: String = "Database.db"
    private var db: OpaquePointer?
    
    private init() {
        db = openDatabase()
    }
    
    private func openDatabase() -> OpaquePointer? {
        let fileURL = Bundle.main.url(forResource: dbPath, withExtension: nil)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL?.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        } else {
            print("Unable to open database.")
            return nil
        }
    }
    
    func readUsers() -> [Item] {
        var items: [Item] = []
        let queryString = "SELECT * FROM Item"
        var queryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = sqlite3_column_text(queryStatement, 2) != nil ? String(cString: sqlite3_column_text(queryStatement, 2)) : nil
                let importance = Int(sqlite3_column_int(queryStatement, 4))
                let type = String(cString: sqlite3_column_text(queryStatement, 5))
                items.append(Item(id: id,name: name, description: description, importance: importance, type: type))
            }
        }
        sqlite3_finalize(queryStatement)
        return items
    }
}
