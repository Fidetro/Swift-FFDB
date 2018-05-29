//
//  Limit.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/29.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
struct Limit:STMT {
    var str: String
    
    init(_ str: String) {
        self.str = "limit" +
                    " " +
                    str
    }
    
    
    func offset(_ offset:String) -> Offset {
        return Offset(str +
                    " " +
                    offset)
    }
}
