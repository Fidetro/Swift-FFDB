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
                    "alter" +
                    " " +
                    stmt
    }
    
    
    
    init(_ table: FFObject.Type) {
        self.stmt = " " +
                    "alter" +
                    " " +
                    table.tableName()
    }
    func add(column:String,def columnDef:String) -> Add {
        return Add.init(stmt, column: column, def: columnDef)
    }
    
}
