//
//  Where.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
struct Where:STMT {
    let str : String
    init(_ str : String) {
        self.str = "where" +
                    " "  +
                    str
        
    }
}
