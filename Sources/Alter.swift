//
//  Alter.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/6/1.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
struct Alter:STMT {
    
    var stmt: String
    
    init(_ stmt: String) {
        self.stmt = " " +
                    "alter table" +
                    " " +
                    stmt
    }
    
    
    
    init(_ table: FFObject.Type) {
        self.init(table.tableName())
        
    }

}

// MARK: - Add
extension Alter {
    func add(column:String,def columnDef:String) -> Add {
        return Add(stmt, column: column, def: columnDef)
    }
    func add(column:String,table:FFObject.Type) -> Add {
        return Add(stmt, column: column, table: table)
    }
}
