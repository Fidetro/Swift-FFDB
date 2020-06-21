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
    
    
    
    func executeDBQuery<R:Decodable>(return type: R.Type,
                                     values: [Any]?,
                                     completion:QueryResult?) throws
    
    func executeDBUpdate(values: [Any]?,
                         completion:UpdateResult?) throws
}

extension STMT {
    public func executeDBQuery<R:Decodable>(return type: R.Type,values: [Any]?,
                                     completion:QueryResult?) throws {
        debugPrintLog("debug sql:"+stmt)
        try FFDB.share.connection().executeDBQuery(return: type, sql: stmt, values: values, completion: completion)
    }
    
    public func executeDBUpdate(values: [Any]?,
                                completion:UpdateResult?) throws {
        debugPrintLog("debug sql:"+stmt)
        try FFDB.share.connection().executeDBUpdate(sql: stmt, values: values, completion: completion)
    }
}
