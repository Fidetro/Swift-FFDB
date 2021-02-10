//
//  STMT.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2018/5/25.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import Foundation
import FMDB
protocol STMT {
    var stmt : String{get}
    
    
    
    func executeDBQuery<R:Decodable>(db: FMDatabase?,
                                     return type: R.Type,
                                     values: [Any]?,
                                     completion:QueryResult?) throws
    
    func executeDBUpdate(db: FMDatabase?,
                         values: [Any]?,
                         completion:UpdateResult?) throws
}

extension STMT {
    public func executeDBQuery<R:Decodable>(db: FMDatabase?,return type: R.Type,values: [Any]?,
                                     completion:QueryResult?) throws {
        debugPrintLog("debug sql:"+stmt)
        try FFDB.share.connection().executeDBQuery(db: db,return: type, sql: stmt, values: values, completion: completion)
    }
    
    public func executeDBUpdate(db: FMDatabase?,
                                values: [Any]?,
                                completion:UpdateResult?) throws {
        debugPrintLog("debug sql:"+stmt)
        try FFDB.share.connection().executeDBUpdate(db: db,sql: stmt, values: values, completion: completion)
    }
}
