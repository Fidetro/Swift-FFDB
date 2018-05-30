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
    
   public init(_ stmt: String) {
        self.stmt = " " +
                    "set" +
                    " " +
                    stmt
    }
    
   public func `where`(_ where:String) -> Where {
        return Where(stmt +
                    " " +
                    `where`)
    }
    
}
