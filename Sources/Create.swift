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
            sqlStatement = (" create table if  not exists \(table.tableName()) (\(createTableSQL(table: table)))")
    }
    
    func createTableSQL(table:FFObject.Type) -> String {
        var sql = String()
        
        if let autoincrementColumn = table.autoincrementColumn() {
            if let customAutoColumn = table.customColumns()?[autoincrementColumn] {
                sql.append("\(customAutoColumn) integer PRIMARY KEY AUTOINCREMENT")
                sql.append(",")
            }else{
                sql.append("\(autoincrementColumn) integer PRIMARY KEY AUTOINCREMENT")
                sql.append(",")
            }
        }
        
        for (index,column) in table.columnsOfSelf().enumerated() {

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
            if table.columnsOfSelf().count-1 != index {
                sql.append(",")
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

