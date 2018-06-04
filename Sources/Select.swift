//
//  Select.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Select:STMT {
   public let stmt : String
    
    public init( _ columns: [String]) {
        var columnString = ""
        for (index,column) in columns.enumerated() {
            if index == 0 {
                columnString += column
            }else{
                columnString = columnString + "," + column
            }
        }
        
        self.init(columnString)
    }
    
    public init(_ stmt : String) {
        self.stmt = "select" +
                    " " +
                    stmt +
                    " "
    }
    

    
    
}

// MARK: - From
extension Select {
    public func from(_ from:String) -> From {
        return From(stmt, format: from)
    }
    
    public func from(_ table:FFObject.Type) -> From {
        return From(stmt, table: table)
    }
}
