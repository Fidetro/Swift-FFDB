//
//  From.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation

public struct From:STMT {
   public let stmt : String
    
}
// MARK: - internal
extension From {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "from" +
                    " " +
                    (format ?? "") +
                    " "
    }
    
    init(_ stmt : String,table:FFObject.Type?=nil) {
        self.init(stmt, format: table?.tableName())
    }
}

// MARK: - Where
extension From {
    public func `where`(_ where:String) -> Where {
        return Where(stmt, format: `where`)
    }
}
// MARK: - Order
extension From {
    public func orderBy(_ orderBy:String) -> OrderBy {
        return OrderBy(stmt, format: orderBy)
    }
    
    public func orderBy(_ orderConditions:[(column:String,orderByType:OrderByType)]) -> OrderBy {
        return OrderBy(stmt, orderConditions)
    }
}

// MARK: - Limit
extension From {
    public func limit(_ limit:String) -> Limit {
        return Limit(stmt, format: limit)
    }
}

// MARK: - Offset
extension From {
    public func offset(_ offset:String) -> Offset {
        return Offset(stmt, format: offset)
    }
}
