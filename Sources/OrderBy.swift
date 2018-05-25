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
        self.str = str
    }
}
