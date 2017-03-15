//
//  SQLiteInterface.swift
//  SmartNTUB
//
//  Created by 謝佳瑋 on 2017/3/15.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation

enum DataAccessError: Error {
    case OpenDataBaseError
    case CreateTableError
    case InsertError
    case DeleteError
    case SearchError
    case NilInData
}

protocol DataHelperProtocol {
    associatedtype kind
    static func createTable() throws -> Void
    static func insert(item: kind) throws -> Int
    static func delete(item: kind) throws -> Void
    static func findAll() throws -> [kind]?
}

class DataBaseInterface {
    var db :OpaquePointer? = nil
    var sqlitePath :String
    
    init?(path :String)throws {
        self.sqlitePath = path
        self.db = self.openDatabase(sqlitePath)
        
        if db == nil {
            throw DataAccessError.OpenDataBaseError
        }
    }
    
    // 連結資料庫 connect database
    func openDatabase(_ path :String) -> OpaquePointer {
        var connectdb: OpaquePointer? = nil
        if sqlite3_open(path, &connectdb) == SQLITE_OK {
            print("LocalDBLog ---------------------> Successfully opened database \(path)")
            return connectdb!
        } else {
            print("LocalDBLog ---------------------> Unable to open database.")
            return connectdb!
        }
    }
}
