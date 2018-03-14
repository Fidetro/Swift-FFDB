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
            sqlStatement = (" create table if  not exists \(table.tableName()) (\(createTableSQL(table: table)))")
        #else
            sqlStatement = (" create table if  not exists \(table.tableName()) (primaryID integer PRIMARY KEY auto_increment\(createTableSQL(table: table)))")
        #endif
    }
    
    func createTableSQL(table:FFObject.Type) -> String {
        var sql = String()
        if let name = table.customColumns()?["primaryID"] {
            sql.append(name+" ")
        }else{
            sql.append("primaryID ")
        }
        if let type = table.customColumnsType()?["primaryID"] {
            sql.append(type)
        }else{
            sql.append("integer PRIMARY KEY AUTOINCREMENT")
        }
        
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
    func execute() throws -> Bool {
 
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return false
        }
        return try FFDB.connect.executeDBUpdate(sql: sql, values: nil, shouldClose: true)
    }
}

