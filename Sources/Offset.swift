//
//  Offset.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/29.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
struct Offset:STMT {
    var str: String
    
    init(_ str: String) {
        self.str = "offset" +
                    " " +
                    str
    }
    
    
}
