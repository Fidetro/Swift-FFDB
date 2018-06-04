//
//  Into.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Into:STMT {
    var stmt: String
    


}

// MARK: - internal
extension Into {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "into" +
                    " " +
                    (format ?? "") +
                    " "
    }
    
    init(_ stmt : String,table:FFObject.Type?=nil) {
        self.init(stmt, format: table?.tableName())
    }
    
}

// MARK: - Columns
extension Into {
    public func columns(_ columns:String) -> Columns {
        return Columns.init(stmt, format: columns)
    }
    public func columns(_ columns:[String]) -> Columns {
        return Columns(stmt, columns: columns)
    }
}
