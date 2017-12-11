//
//  FFDBConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/14.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

public protocol FFDBConnect {

    static func executeDBUpdate(sql:String,values:[Any]?,shouldClose:Bool) -> Bool
    
    static func executeDBQuery<T:Decodable>(return type:T.Type, sql:String,values:[Any]?,shouldClose:Bool) -> Array<Decodable>?
    
    static func columnExists(_ columnName : String, inTableWithName: String) -> Bool
    
}

extension FFDBConnect {
    
}

public enum FFDBConnectType {
    case FMDB
    public  func connect() -> FFDBConnect.Type {
            switch self {
            case .FMDB:
                return FMDBConnect.self
            }

    }
}
