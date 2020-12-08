//
//  Limit.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/29.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Limit:STMT {
   public let stmt: String
    

}

// MARK: - internal
extension Limit {
    init(_ stmt : String,format:String?=nil) {
        if let format = format {
        self.stmt = stmt +
                    "limit" +
                    " " +
                    format +
                    " "
        } else {
            self.stmt = stmt + " "
        }
    }
}

// MARK: - Offset
extension Limit {
    public func offset(_ offset:String) -> Offset {
        return Offset(stmt, format: offset)
    }
}
