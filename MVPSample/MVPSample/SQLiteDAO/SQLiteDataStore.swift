//
//  SQLiteDataStore.swift
//  SmartNTUB
//
//  Created by 謝佳瑋 on 2017/3/15.
//  Copyright © 2017年 謝佳瑋. All rights reserved.
//

import Foundation

class SQLiteDataStore:DataBaseInterface {

    
    // 建立資料表 create table
    func createTable(tableName :String, columnsInfo :[String])throws{
        let sql = "create table if not exists \(tableName) " + "(\(columnsInfo.joined(separator: ",")))" as NSString
        
        if sqlite3_exec(self.db, sql.utf8String, nil, nil, nil) == SQLITE_OK{
            print("LocalDBLog ---------------------> Create \(tableName) is \"Success\".")
        }else{
            print("LocalDBLog ---------------------> Create \(tableName) is \"Fail\".")
            throw DataAccessError.CreateTableError
        }
        
    }
    
    // 新增資料
    func insert(_ tableName :String, rowInfo :[String:String])throws{
        var statement :OpaquePointer? = nil
        let sql = "insert into \(tableName) " + "(\(rowInfo.keys.joined(separator: ","))) " + "values " + "(\(rowInfo.values.joined(separator: ",")))"
            as NSString
        //print(sql.debugDescription)
        if sqlite3_prepare_v2(self.db, sql.utf8String, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("LocalDBLog ---------------------> Insert data in \(tableName) is \"Success\".")
                // return true
            }
            sqlite3_finalize(statement)
        }else{
            print("LocalDBLog ---------------------> Insert data in \(tableName) is \"Fail\".")
        }
        
        //return false
    }
    
    // 讀取資料
    func fetch(_ tableName :String, cond :String?, order :String?)-> OpaquePointer {
        var statement :OpaquePointer? = nil
        var sql = "select * from \(tableName)"
        if let condition = cond {
            sql += " where \(condition)"
        }
        
        if let orderBy = order {
            sql += " order by \(orderBy)"
        }
        
        sqlite3_prepare_v2(self.db, (sql as NSString).utf8String, -1,&statement, nil)
        
        return statement!
    }
    
    //查詢
    func filter(_ tableName :String, cond :String?, select :String?)-> OpaquePointer{
        var statement :OpaquePointer? = nil
        var sql = "select \(select!) from \(tableName)"
        if let condition = cond {
            sql += " where \(condition)"
        }
        
        sqlite3_prepare_v2(self.db, (sql as NSString).utf8String, -1,&statement, nil)
        
        return statement!
    }
    
    // 更新資料
    func update(_ tableName :String,cond :String?, rowInfo :[String:String]){
        var statement :OpaquePointer? = nil
        var sql = "update \(tableName) set "
        
        // row info
        var info :[String] = []
        for (k, v) in rowInfo {
            info.append("\(k) = \(v)")
        }
        sql += info.joined(separator: ",")
        
        // condition
        if let condition = cond {
            sql += " where \(condition)"
        }
        
        if sqlite3_prepare_v2(self.db, (sql as NSString).utf8String, -1,&statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("LocalDBLog ---------------------> Update data in \(tableName) is \"Success\".")
                //return true
            }
            sqlite3_finalize(statement)
        }else{
            print("LocalDBLog ---------------------> Update data in \(tableName) is \"Fail\".")
        }
        
        //return false
        
    }
    
    // 刪除資料
    func delete(_ tableName :String, cond :String?){
        var statement :OpaquePointer? = nil
        var sql = "delete from \(tableName)"
        
        // condition
        if let condition = cond {
            sql += " where \(condition)"
        }
        
        if sqlite3_prepare_v2(
            self.db, (sql as NSString).utf8String, -1,&statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("LocalDBLog ---------------------> Delete data in \(tableName) is \"Success\".")
                //return true
            }
            sqlite3_finalize(statement)
        }else{
            print("LocalDBLog ---------------------> Delete data in \(tableName) is \"Fail\".")
        }
        //return false
    }
    
    func alter(_ tableName :String, cond :String?){
        var statement :OpaquePointer? = nil
        var sql = "alter table " + tableName + cond!
        if sqlite3_prepare_v2(self.db, (sql as NSString).utf8String, -1,&statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("LocalDBLog ---------------------> alter in \(tableName) is \"Success\".")
                //return true
            }
            sqlite3_finalize(statement)
        }else{
            print("LocalDBLog ---------------------> alter in \(tableName) is \"Fail\".")
        }
    }
}
