//
//  OrderBy.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
struct OrderBy:STMT {
    let str : String
    init(_ str : String) {
        self.str = "orderby" +
                   " "  +
                   str
    }
    
    func limit(_ limit:String) -> Limit {
        return Limit(str +
            " " +
            limit)
    }
    
    func offset(_ offset:String) -> Offset {
        return Offset(str +
            " " +
            offset)
    }
}
