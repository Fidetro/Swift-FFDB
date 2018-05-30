//
//  Update.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Update:STMT {
    let stmt: String
    
    public init(_ stmt: String) {
        self.stmt = " " +
                    "update" +
                    " " +
                    stmt
    }
    
    public func set(_ set:String) -> Set {
        return Set(stmt +
                    " " +
                    set +
                    " ")
    }
    
}
