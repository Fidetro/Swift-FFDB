//
//  Set.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Set:STMT {
    let stmt: String
    
}

// MARK: - internal
extension Set {

    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "set" +
                    " " +
                    (format ?? "") +
                    " "
    }
    
    init(_ stmt : String,columns:[String]?=nil) {
        var columnsString = ""
        if let columns = columns {
            for (index,column) in columns.enumerated() {
                if index == 0 {
                    columnsString.append(column+"="+"?")
                }else{
                    columnsString.append(","+column+"="+"?")
                }
            }
        }
        self.init(stmt, format: columnsString)
    }
}

// MARK: - Set
extension Set {
    public func `where`(_ where:String) -> Where {
        return Where(stmt, format: `where`)
    }
}
