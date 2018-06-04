//
//  Where.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Where:STMT {
   public let stmt : String
    
}

// MARK: - internal
extension Where {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "where" +
                    " " +
                    (format ?? "") +
                    " "
    }
}

// MARK: - Order
extension Where {
    public func orderBy(_ orderBy:String) -> OrderBy {
        return OrderBy.init(stmt, format: orderBy)
    }
    
    public func orderBy(_ orderConditions:[(column:String,orderByType:OrderByType)]) -> OrderBy {
        
        return OrderBy(stmt, orderConditions)
    }
}

// MARK: - Limit
extension Where {
    public func limit(_ limit:String) -> Limit {
        return Limit(stmt, format: limit)
    }
}

// MARK: - Offset
extension Where {
    public func offset(_ offset:String) -> Offset {
        return Offset(stmt, format: offset)
    }
}
