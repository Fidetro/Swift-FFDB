//
//  From.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation

struct From:STMT {
    let str : String
    init(_ str : String) {
        self.str = str
    }
    func `where`(_ where:String) -> Where {
        return Where(str+" "+`where`)
    }
    
    func orderBy(_ orderBy:String) -> OrderBy {
        return OrderBy(str+" "+orderBy)
    }
}
