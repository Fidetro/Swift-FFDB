//
//  Where.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Where:STMT {
    let stmt : String
    public init(_ stmt : String) {
        self.stmt = " " +
                    "where" +
                    " "  +
                    stmt
        
    }
}
