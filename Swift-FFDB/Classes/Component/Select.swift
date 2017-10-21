//
//  Select.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



struct Select {
    
    fileprivate var tableClass : FFObject.Type?
    fileprivate var returnType : Decodable.Type?
    var sqlStatement : String?
    public  init() {
        sqlStatement = ""
        sqlStatement?.append(" select " + " * ")
    }
    public  init(_ columns:[String]) {
        sqlStatement = ""
        sqlStatement?.append(" select " + columns.stringToColumns())
    }
    public    func from(_ table:FFObject.Type) -> Select {
        var select = self
        select.tableClass = table
        select.sqlStatement?.append(" from " + table.tableName())
        return select
    }
    public   func whereFormat(_ condition:String) -> Select {
        var select = self
        select.sqlStatement?.append(" where " + condition + " ")
        return select
    }
    public   func returnType(_ type:Decodable.Type) -> Select {
        var select = self
        select.returnType = type
        return select
    }
    public  func execute<T:Decodable>(_ type:T.Type) -> Array<Decodable>? {
        guard let connect = FFDB.connect else {
            assertionFailure("must be instance FFDB.setup(_ type:FFDBConnectType)")
            return nil
        }
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return nil
        }
        return connect.executeDBQuery(return: type.self, sql: sql)
        
    }
}

extension Array {
    fileprivate func stringToColumns() -> String {
        var columnsString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                columnsString.append(anyToString(element))
            }else{
                columnsString.append(","+anyToString(element))
            }
        }
        return columnsString
    }
    
    fileprivate func stringToValues() -> String {
        var valuesString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                valuesString.append(anyToString(element))
            }else{
                valuesString.append(","+anyToString(element))
            }
        }
        return valuesString
    }
}
