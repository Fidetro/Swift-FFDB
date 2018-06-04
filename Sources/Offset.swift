//
//  Offset.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/29.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Offset:STMT {
   public let stmt: String
    
}

// MARK: - internal
extension Offset {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "offset" +
                    " " +
                    (format ?? "") +
                    " "
    }
}
