//
//  Insert.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/27.
//  Copyright © 2017年 Fidetro. All rights reserved.
//
import FMDB

public struct Insert {
    
    fileprivate var tableClass : FFObject.Type?
    
    var sqlStatement : String?
    private var values = [Any]()
    
    init() {
        sqlStatement = ""
        tableClass = nil
    }
    
    public   func into(_ table:FFObject.Type) -> Insert {
        var insert = self
        insert.tableClass = table
        insert.sqlStatement?.append(" insert into " + table.tableName())
        
        return insert
    }
    
    public  func columns(_ columnsArray:[String]?) -> Insert {
        var insert = self
        var columnsString = String()
        if let columns = columnsArray {
            columnsString = columns.stringToColumns()
        }else{
            if let classColumns = insert.tableClass?.columnsOfSelf() {
                columnsString = classColumns.stringToColumns()
            }else{
                assertionFailure("tableClass is nil")
            }
        }
        insert.sqlStatement?.append(" \(columnsString) ")
        return insert
    }
    
    public  func columns(_ table:FFObject.Type) -> Insert {
        return self.columns(table.columnsOfSelf())
    }
    
    public   func values(_ valuesArray:[Any]) -> Insert {
        var insert = self
        insert.values.append(contentsOf: valuesArray)
        return insert
    }
    public   func values(_ object:FFObject) -> Insert {
        var insert = self
        for value in object.allValue() {
            insert.values.append(value)
        }
        return insert
    }
    
    public  func execute(database db:FMDatabase? = nil) throws -> Bool {
        
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return false
        }
        
        guard let db = db else {
            return try FFDB.connect.executeDBUpdate(sql: sql, values: self.values, shouldClose: true)
        }
        return try db.executeDBUpdate(sql: sql, values: self.values, shouldClose: false)
        
    }
}

extension Array {
    fileprivate func stringToColumns() -> String {
        var columnsString = String()
        columnsString.append("(")
        for (index,element) in self.enumerated() {
            if index == 0 {
                columnsString.append(anyToString(element))
            }else{
                columnsString.append(","+anyToString(element))
            }
        }
        columnsString.append(")")
        columnsString.append(" values ")
        columnsString.append("(")
        let count = self.count
        for index in 0..<count {
            if index == 0 {
                columnsString.append("?")
            }else{
                columnsString.append(",?")
            }
        }
        columnsString.append(")")
        return columnsString
    }
    
    fileprivate func stringToValues() -> String {
        var valuesString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                valuesString.append("\'\(anyToString(element))\'")
            }else{
                valuesString.append(","+"\'\(anyToString(element))\'")
            }
        }
        return valuesString
    }
}

