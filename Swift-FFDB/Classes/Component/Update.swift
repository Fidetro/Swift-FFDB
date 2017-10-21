//
//  Update.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



struct Update {
    
    fileprivate var tableClass : FFObject.Type?
    fileprivate var updateObject : FFObject?
    
    var sqlStatement : String?


    init(_ table:FFObject.Type) {
        tableClass = table
        sqlStatement = ""
        sqlStatement?.append(" update " + table.tableName())
    }
    
    init(_ object:FFObject) {
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
    
    func set() -> Update {
        var update = self
        var sqlFormat = String()
        if let object = self.updateObject {
            sqlFormat.append(columnsToSetSQLFormat(object, nil))
        }else{
            assertionFailure("please use init(_ object:FFDataBaseModel)")
        }
        update.sqlStatement?.append(" set " + sqlFormat + " ")
        return update
    }
    
    func set(_ columns:[String]) -> Update {
        var update = self
        var sqlFormat = String()
        if let object = self.updateObject {
            sqlFormat.append(columnsToSetSQLFormat(object, columns))
        }else{
            assertionFailure("please use init(_ object:FFDataBaseModel)")
        }
        update.sqlStatement?.append(" set " + sqlFormat + " ")
        return update
    }
    
    func set(_ condition:String) -> Update {
        var update = self
        update.sqlStatement?.append(" set " + condition + " ")
        return update
    }
    
    func whereFormat(_ condition:String) -> Update {
        var update = self
        update.sqlStatement?.append(" where " + condition + " ")
        return update
    }
    
    func execute() -> Bool {
        guard let connect = FFDB.connect else {
            assertionFailure("must be instance FFDB.setup(_ type:FFDBConnectType)")
            return false
        }
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return false
        }
        return connect.executeDBUpdateAfterClose(sql: sql)
    }
    
    private func columnsToSetSQLFormat(_ object:FFObject ,_ columns:[String]?) -> String {
        var SQLFormat = String()
        let mirror = Mirror(reflecting: object)
        var index = 0
        
        if let inputColumns = columns {
            for column in inputColumns {
                var isContain = false
                for case let (key?,value) in mirror.children {
                    if key == "primaryID" {
                        continue;
                    }
                    if key == column {
                        isContain = true
                            if index == 0 {
                                index += 1
                                SQLFormat.append(key + "=" + "'\(anyToString(value))'")
                            }else{
                                SQLFormat.append("," + key + "=" + "'\(anyToString(value))'")
                            }
                    }
                }
                if isContain == false {
                    assertionFailure("can't find \(column) property")
                }
            }
        }
        return SQLFormat
    }
}
