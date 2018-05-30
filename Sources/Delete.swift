//
//  Delete.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Delete:STMT {
    let stmt: String
    
    public init(_ stmt: String) {
        self.stmt = " " +
                    "delete" +
                    " " +
                    stmt
    }
    
    public func from(_ from:String) -> From {
        return From(stmt +
                    " " +
                    from +
                    " ")
    }
    
}
