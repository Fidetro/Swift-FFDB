//
//  Update.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import FMDB

public struct Update {
    
    fileprivate var tableClass : FFObject.Type?
    private var values = [Any]()
    var sqlStatement : String?
    
    
    public  init(_ table:FFObject.Type) {
        tableClass = table
        sqlStatement = ""
        sqlStatement?.append(" update " + table.tableName())
    }
    
    
    
    public func set(_ columns:[String]) -> Update {
        var update = self
        var sqlFormat = String()
        sqlFormat.append(columnsToSetSQLFormat(columns, update: &update))
        update.sqlStatement?.append(" set " + sqlFormat + " ")
        return update
    }
    
    public func set(_ condition:String) -> Update {
        var update = self
        update.sqlStatement?.append(" set " + condition + " ")
        return update
    }
    
    public  func whereFormat(_ condition:String) -> Update {
        var update = self
        update.sqlStatement?.append(" where " + condition + " ")
        return update
    }
    
    public func execute(database db:FMDatabase? = nil,values valuesArray:[Any]? = nil) throws -> Bool {
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return false
        }
        var update = self
        if let values = valuesArray {
            update.values = [Any]()
            for value in values {
                update.values.append(value)
            }
        }
        
        guard let db = db else {
            return try FFDB.connect.executeDBUpdate(sql: sql, values: update.values, shouldClose: true)
        }
        return try db.executeDBUpdate(sql: sql, values: update.values, shouldClose: false)
    }
    
    private func columnsToSetSQLFormat(_ columns:[String]?, update:inout Update) -> String {
        
        var SQLFormat = String()
        
        for (index,column) in columns!.enumerated() {
            if index == 0 {
                SQLFormat.append(column + "=" + "?")
            }else{
                SQLFormat.append("," + column + "=" + "?")
            }
        }
        return SQLFormat
    }
}
