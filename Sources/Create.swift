//
//  Create.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/6/1.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation



public struct Create :STMT {
    var stmt: String
    
    public init(_ stmt: String) {
        self.stmt = " " +
                    "create" +
                    " " +
                    stmt
    }
    
    public init(_ table:FFObject.Type) {
        self.init("table if  not exists \(table.tableName()) (\(createTableSQL(table: table)))")
    }
    
    
}

fileprivate func createTableSQL(table:FFObject.Type) -> String {
    var sql = String()
    
    let primaryKeyColumn = table.primaryKeyColumn()
    let type = table.customColumnsType()?[primaryKeyColumn] ?? "integer PRIMARY KEY AUTOINCREMENT"
    if let customAutoColumn = table.customColumns()?[primaryKeyColumn] {
        sql.append("\(customAutoColumn) \(type)")
        sql.append(",")
    }else{
        sql.append("\(primaryKeyColumn) \(type)")
        sql.append(",")
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
