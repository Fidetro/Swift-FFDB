//
//  Columns.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Columns:STMT {
    let stmt: String
    
    

    
}

// MARK: - internal
extension Columns {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = " " +
                    stmt +
                    " " +
                    (format ?? "") +
                    " "
    }
      init(_ stmt : String,columns:[String]) {
        self.init(stmt, format: columns.stringToColumns())
    }
}

// MARK : - Values
extension Columns {
    public func values(_ count:Int) -> Values {                
        return Values(stmt, count: count)
    }
    
    public func values(_ values:String) -> Values {
        return Values(stmt, format: values)
    }
}

fileprivate extension Array {
    fileprivate func stringToColumns() -> String {
        var columnsString = String()
        columnsString.append("(")
        for (index,element) in self.enumerated() {
            if index == 0 {
                columnsString.append(anyToString(element))
            }else{
                columnsString.append(","+anyToString(element))
            }
        }
        columnsString.append(")")
        return columnsString
    }
    
}
