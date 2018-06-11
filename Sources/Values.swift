//
//  Values.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/30.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
public struct Values:STMT {
    let stmt: String
    
}

// MARK: - internal
extension Values {
    init(_ stmt : String,format:String?=nil) {
        self.stmt = stmt +
                    "values" +
                    " " +
                    (format ?? "") +
                    " "
    }
    init(_ stmt : String,count:Int?=0) {
        var valuesString = "("
        
        for index in 0..<( count ?? 0) {
            if index == 0 {
                valuesString.append("?")
            }else{
                valuesString.append(",?")
            }
        }
        valuesString.append(")")
        self.init(stmt, format: valuesString)
    }
}
