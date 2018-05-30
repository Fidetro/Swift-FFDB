//
//  Values.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Values:STMT {
    var stmt: String
    
    public init(_ str: String) {
        self.stmt = " " +
                    "values" +
                    " " +
                    str
    }
    
}
