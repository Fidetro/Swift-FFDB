//
//  OrderBy.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct OrderBy:STMT {
    let stmt : String
    public init(_ stmt : String) {
        self.stmt = " "  +
                    "orderby" +
                    " "  +
                    stmt
    }
    
    public func limit(_ limit:String) -> Limit {
        return Limit(stmt +
                     " " +
                    limit)
    }
    
    public func offset(_ offset:String) -> Offset {
        return Offset(stmt +
                    " " +
                    offset)
    }
}
