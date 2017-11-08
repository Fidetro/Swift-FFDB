//
//  Delete.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


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
  public  func execute(values valuesArray:[Any]? = nil) -> Bool {
        guard let connect = FFDB.connect else {
            assertionFailure("must be instance FFDB.setup(_ type:FFDBConnectType)")
            return false
        }
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
        return connect.executeDBUpdate(sql: sql, values: values, shouldClose: true)
    }
}

