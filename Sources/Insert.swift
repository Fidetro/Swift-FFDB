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

    public init(_ stmt: String?=nil) {
        if let stmt = stmt {
            self.stmt = "insert" +
                        " " +
                        stmt +
                        " "
        }else{
            self.stmt = "insert" +
                        " "
        }
    }
    

}


// MARK: - Into
extension Insert {
    public func into(_ into:String) -> Into {
        return Into(stmt, format: into)
    }
    
    public func into(_ table:FFObject.Type) -> Into {
        return Into(stmt, table: table)
    }
}
