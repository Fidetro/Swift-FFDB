//
//  PerfectMySQLConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


struct PerfectMySQLConnect :FFDBConnect {
    static func columnExists(_ columnName: String, inTableWithName: String) -> Bool {
        return false
    }
    
    
    
    static func executeDBUpdate(sql: String) -> Bool {
        return false
    }
    
    static func executeDBUpdateAfterClose(sql: String) -> Bool {
        return false
    }
    
    static func executeDBQuery<T>(return type: T.Type, sql: String) -> Array<Decodable>? where T : Decodable {
        return nil
    }
    
    
}

