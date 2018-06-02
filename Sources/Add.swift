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
                    "add column" +
                    " " +
                    (format ?? "") +
                    " "
    }
    init(_ stmt : String,column:String,def columnDef:String) {
        self.init(stmt, format: column + " " + columnDef)
    }
    
}
