//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

struct FFDB {
    static var connect : FFDBConnect.Type?
    static func setup(_ type:FFDBConnectType){
        connect = type.connect()
    }
}



protocol FIDRuntime {
    init()
    
    /// 获取对象类型
    var subType : Any.Type {get}
    
    func valueToNotNull(_ value:Any) -> String
    /// 相当于Objective-C中的valueForKey: 
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueFrom(_ key: String) -> Any?
}

protocol FFObject:FIDRuntime,Decodable {
    var primaryID : Int64? {get}
    
    
    static func registerTable() -> Bool
    static func select(_ condition:String?) -> Array<FFObject>?
    func insert() -> Bool
    func update() -> Bool
    func delete() -> Bool
    
    
    /// 相当于Objective-C中的valueForKey: 但返回的值永远不会为空
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueNotNullFrom(_ key: String) -> String
    static func columnsOfSelf() -> Array<String>
    static func memoryPropertys() -> [String]?
    static func columnsType() -> [String:String]?
    static func customColumns() -> [String:String]?
    static  func tableName() -> String
}






