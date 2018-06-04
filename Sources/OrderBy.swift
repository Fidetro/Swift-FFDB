//
//  OrderBy.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public enum OrderByType {
    case desc
    case asc
}

public struct OrderBy:STMT {
   public let stmt : String

}

// MARK: - internal
extension OrderBy {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "orderby" +
                    " " +
                    (format ?? "") +
                    " "
    }
    
    init(_ stmt : String,_ orderConditions:[(column:String,orderByType:OrderByType)]) {
        var orderString = ""
        for (index,orderCondition) in orderConditions.enumerated() {
            
            if index == 0 {
                orderString = orderString +
                    orderCondition.column +
                    (orderCondition.orderByType == .asc ? "asc":"desc")
            }else{
                orderString = orderString +
                    "," +
                    orderCondition.column +
                    (orderCondition.orderByType == .asc ? "asc":"desc")
            }
        }
        self.init(stmt, format: orderString)
    }
    
}

// MARK: - Limit
extension OrderBy {
    public func limit(_ limit:String) -> Limit {
        return Limit(stmt, format: limit)
    }
}


// MARK: - Offset
extension OrderBy {
    public func offset(_ offset:String) -> Offset {
        return Offset(stmt, format: offset)
    }
}
