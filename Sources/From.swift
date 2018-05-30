//
//  From.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation

public struct From:STMT {
    let stmt : String
    public init(_ stmt : String) {
        self.stmt = " " +
                    "from" +
                    " " +
                    stmt
    }
    public func `where`(_ where:String) -> Where {
        return Where(stmt +
                    " " +
                    `where`)
    }
    
    public func orderBy(_ orderBy:String) -> OrderBy {
        return OrderBy(stmt +
                       " " +
                        orderBy)
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
