//
//  Alter.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/17.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



struct Alter {
    fileprivate var tableClass : FFObject.Type?
//    var sqlStatement : String?
    init(_ table:FFObject.Type) {
        tableClass = table
        
    }
    func execute() -> Bool {
        guard let connect = FFDB.connect else {
            assertionFailure("must be instance FFDB.setup(_ type:FFDBConnectType)")
            return false
        }
        guard let table = tableClass else {
            assertionFailure("tableClass can't nil,use init(_ table:FFObject.Type)")
            return false
        }
        guard let newColumns = findNewColumns(table) else {
            return true
        }

        var result = true
        for newColumn in newColumns {
            var sql =  "alter table `\(table.tableName())` add "
            sql.append(alterColumnsInTableSQL(newColumn))
            let alterResult = connect.executeDBUpdateAfterClose(sql: sql)
            if alterResult == false {
                result = false
            }
        }
        
        return result
    }
    func alterColumnsInTableSQL(_ newColumn:String) -> String {
        var sql = String()
    
  
            sql.append(" \(newColumn) ")
            if let type = tableClass?.customColumnsType()?[newColumn] {
                sql.append(type)
            }else{
                if let type = tableClass?.columnsType()[newColumn]{
                    sql.append(type)
                }else{
                    sql.append("TEXT")
                }
            }
        return sql
    }
    func findNewColumns(_ table:FFObject.Type) -> [String]? {
        var newColumns = [String]()
        for column in table.columnsOfSelf() {
            guard let connect = FFDB.connect else {
                assertionFailure("must be instance FFDB.setup(_ type:FFDBConnectType)")
                return nil
            }
            let result = connect.columnExists(column, inTableWithName: table.tableName())
            if result == false {
                newColumns.append(column)
            }
        }
        guard newColumns.count != 0 else {
            return nil
        }
        return newColumns
    }
}
