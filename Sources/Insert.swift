//
//  Insert.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation

public struct Insert:STMT {
    var stmt: String
    
    public init(_ stmt: String) {
        self.stmt = " " +
                    "insert" +
                    " " +
                    stmt
    }
    
    public func into(_ into:String) -> Into {
        return Into(stmt +
                    " " +
                    into +
                    " ")
    }
}
