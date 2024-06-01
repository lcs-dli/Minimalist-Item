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
    // Create
        func createItem(item: Item) -> Bool {
            let insertStatementString = "INSERT INTO Item (name, description, importance, type) VALUES (?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, (item.name as NSString).utf8String, -1, nil)
                if let description = item.description {
                    sqlite3_bind_text(insertStatement, 2, (description as NSString).utf8String, -1, nil)
                } else {
                    sqlite3_bind_null(insertStatement, 2)
                }
                sqlite3_bind_int(insertStatement, 3, Int32(item.importance))
                sqlite3_bind_text(insertStatement, 4, (item.type as NSString).utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                    sqlite3_finalize(insertStatement)
                    return true
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
            return false
        }
    
    //read
    func readItems() -> [Item] {
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
    
    //update
        func updateItem(item: Item) -> Bool {
            let updateStatementString = "UPDATE Item SET name = ?, description = ?, importance = ?, type = ? WHERE id = ?;"
            var updateStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(updateStatement, 1, (item.name as NSString).utf8String, -1, nil)
                if let description = item.description {
                    sqlite3_bind_text(updateStatement, 2, (description as NSString).utf8String, -1, nil)
                } else {
                    sqlite3_bind_null(updateStatement, 2)
                }
                sqlite3_bind_int(updateStatement, 3, Int32(item.importance))
                sqlite3_bind_text(updateStatement, 4, (item.type as NSString).utf8String, -1, nil)
                sqlite3_bind_int(updateStatement, 5, Int32(item.id!))
                
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("Successfully updated row.")
                    sqlite3_finalize(updateStatement)
                    return true
                } else {
                    print("Could not update row.")
                }
            } else {
                print("UPDATE statement could not be prepared.")
            }
            sqlite3_finalize(updateStatement)
            return false
        }
    
    //delete
        func deleteItem(by id: Int) -> Bool {
            let deleteStatementString = "DELETE FROM Item WHERE id = ?;"
            var deleteStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
                sqlite3_bind_int(deleteStatement, 1, Int32(id))
                
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted row.")
                    sqlite3_finalize(deleteStatement)
                    return true
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared.")
            }
            sqlite3_finalize(deleteStatement)
            return false
        }
}
