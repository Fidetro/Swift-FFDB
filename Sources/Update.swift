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
    fileprivate var updateObject : FFObject?
    private var values = [Any]()
    var sqlStatement : String?
    
    
    public  init(_ table:FFObject.Type) {
        tableClass = table
        sqlStatement = ""
        sqlStatement?.append(" update " + table.tableName())
    }
    
    public  init(_ object:FFObject) {
        tableClass = object.subType
        updateObject = object
        sqlStatement = ""
        if tableClass?.columnsOfSelf() != nil  {
            if let tableName = tableClass?.tableName() {
                sqlStatement?.append(" update " + tableName)
            }
        }else{
            assertionFailure("columns is nil")
        }
    }
    
    public  func set() -> Update {
        var update = self
        var sqlFormat = String()
        if let object = self.updateObject {
            sqlFormat.append(columnsToSetSQLFormat(object, nil, update: &update))
        }else{
            assertionFailure("please use init(_ object:FFDataBaseModel)")
        }
        update.sqlStatement?.append(" set " + sqlFormat + " ")
        
        return update
    }
    
    public  func set(_ columns:[String]) -> Update {
        var update = self
        var sqlFormat = String()
        if let object = self.updateObject {
            sqlFormat.append(columnsToSetSQLFormat(object, columns, update: &update))
        }else{
            sqlFormat.append(columnsToSetSQLFormat(nil, columns, update: &update))
        }
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
    
    func columnsToSetSQLFormat(_ object:FFObject? ,_ columns:[String]?, update:inout Update) -> String {
        
        var SQLFormat = String()
        
        guard let obj = object else {
            for (index,column) in columns!.enumerated() {
                if index == 0 {
                    SQLFormat.append(column + "=" + "?")
                }else{
                    SQLFormat.append("," + column + "=" + "?")
                }
            }
            return SQLFormat
        }
        
        let mirror = Mirror(reflecting: obj)
        var index = 0
        var columns = columns
        if let _ = columns {
        }else{
            columns = tableClass!.columnsOfSelf()
        }
        for column in columns! {
            var isContain = false
            for case let (key?,value) in mirror.children {
                if key == "primaryID" {
                    continue;
                }
                if key == column {
                    isContain = true
                    if index == 0 {
                        index += 1
                        SQLFormat.append(key + "=" + "?")
                        update.values.append(anyToString(value))
                    }else{
                        SQLFormat.append("," + key + "=" + "?")
                        update.values.append(anyToString(value))
                    }
                }
            }
            if isContain == false {
                assertionFailure("can't find \(column) property")
            }
        }
        return SQLFormat
    }
}
