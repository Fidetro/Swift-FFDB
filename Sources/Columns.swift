//
//  Columns.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
import UIKit
public struct Columns:STMT {
    let stmt: String
    
}

// MARK: - internal
extension Columns {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    (format ?? "") +
                    " "
    }
      init(_ stmt : String,columns:[String]) {
        
         func columnsToString(_ columns:[String]) -> String {
            var columnsString = String()
            columnsString.append("(")
            for (index,element) in columns.enumerated() {
                if index == 0 {
                    columnsString.append(element)
                }else{
                    columnsString.append(","+element)
                }
            }
            columnsString.append(")")
            return columnsString
        }
        
        self.init(stmt, format: columnsToString(columns))
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

