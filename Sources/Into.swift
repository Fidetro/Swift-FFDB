//
//  Into.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Into:STMT {
    var stmt: String
    
    public init(_ stmt: String) {
        self.stmt = " " +
                    "into" +
                    " " +
                    stmt
    }
    public func values(_ values:String) -> Values {
        return Values(stmt +
                        " " +
                        values +
                        " ")
    }
   
    
    
}
