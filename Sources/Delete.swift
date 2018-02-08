//
//  Delete.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import FMDB

public struct Delete {
    fileprivate var tableClass : FFObject.Type?
    var sqlStatement : String?
    private var values = [Any]()
    public   init() {
        sqlStatement = ""
        sqlStatement?.append(" delete ")
    }
    
    
    public   func from(_ table:FFObject.Type) -> Delete {
        var delete = self
        delete.tableClass = table
        delete.sqlStatement?.append(" from " + table.tableName())
        return delete
    }
    
    public   func whereFormat(_ condition:String) -> Delete {
        var delete = self
        delete.sqlStatement?.append(" where " + condition + " ")
        return delete
    }
    public   func values(_ valuesArray:[Any]) -> Delete {
        var delete = self
        delete.values.append(contentsOf: valuesArray)
        return delete
    }
    public func execute(database db:FMDatabase? = nil,values valuesArray:[Any]? = nil) throws -> Bool {
        
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return false
        }
        var delete = self
        if let values = valuesArray {
            for value in values {
                delete.values.append(value)
            }
        }
        guard let db = db else {
            return try FFDB.connect.executeDBUpdate(sql: sql, values: delete.values, shouldClose: true)
        }
        return try db.executeDBUpdate(sql: sql, values: delete.values, shouldClose: false)
    }
}

