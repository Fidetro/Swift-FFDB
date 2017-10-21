//
//  Create.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/14.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

struct Create {
    fileprivate var tableClass : FFObject.Type?
    var sqlStatement : String?

    init(_ table:FFObject.Type) {
        tableClass = table
        #if os(iOS)
            sqlStatement = (" create table if  not exists \(table.tableName()) (primaryID integer PRIMARY KEY AUTOINCREMENT\(createTableSQL(table: table)))")
        #else
            sqlStatement = (" create table if  not exists \(table.tableName()) (primaryID integer PRIMARY KEY auto_increment\(createTableSQL(table: table)))")
        #endif
    }
    
    func createTableSQL(table:FFObject.Type) -> String {
        var sql = String()
        for column in table.columnsOfSelf() {
            sql.append(",")
            if let name = table.customColumns()?[column] {
                sql.append(name)
            }else{
                sql.append(column)
            }
            sql.append(" ")
            if let type = table.customColumnsType()?[column] {
                sql.append(type)
            }else{
                if let type = table.columnsType()[column]{
                    sql.append(type)
                }else{
                sql.append("TEXT")
                }
            }
        }
        return sql
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
}

