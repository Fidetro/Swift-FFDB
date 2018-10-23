//
//  Add.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/6/1.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation

struct Add:STMT {
    var stmt: String
    
    
}

// MARK: - internal
extension Add {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = " " +
                    stmt +
                    " " +
                    "add" +
                    " " +
                    (format ?? "") +
                    " "
    }
    
    init(_ stmt : String,column:String,def columnDef:String) {
        self.init(stmt, format: column + " " + columnDef)
    }
    
    init(_ stmt : String,column:String,table:FFObject.Type) {
        self.init(stmt, format: alterColumnsInTableSQL(column, table: table))
    }
}

fileprivate func alterColumnsInTableSQL(_ newColumn:String,table:FFObject.Type) -> String {
    var sql = String()
    
    sql.append(" \(newColumn) ")
    
    if let type = table.columnsType()[newColumn]{
        sql.append(type)
    }else{
        sql.append("TEXT")
    }
    return sql
}
