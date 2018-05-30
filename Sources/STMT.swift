//
//  STMT.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
protocol STMT {
    var stmt : String{get}
    
    init(_ stmt : String)
    
    func executeDBQuery<R:Decodable>(return type: R.Type,
                                     sql: String,
                                     values: [Any]?,
                                     completion:QueryResult?) throws
    
    func executeDBUpdate(sql: String,
                         values: [Any]?,
                         completion:UpdateResult?) throws
}

extension STMT {
    public func executeDBQuery<R:Decodable>(return type: R.Type,
                                     sql: String,
                                     values: [Any]?,
                                     completion:QueryResult?) throws {
        try FFDB.share.connection().executeDBQuery(return: type, sql: sql, values: values, completion: completion)
    }
    
    public func executeDBUpdate(sql: String,
                         values: [Any]?,
                         completion:UpdateResult?) throws {
        try FFDB.share.connection().executeDBUpdate(sql: sql, values: values, completion: completion)
    }
}
