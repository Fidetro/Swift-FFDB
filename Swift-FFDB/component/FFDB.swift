//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



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

protocol FFObject:FIDRuntime {
    var primaryID : Int64? {get}
    /// 相当于Objective-C中的valueForKey: 但返回的值永远不会为空
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueNotNullFrom(_ key: String) -> String

    static  func tableName() -> String
    static func columnsOfSelf() -> Array<String>
    static func select(_ condition:String) -> Array<FFObject>?
    func insert() -> Bool
    func update() -> Bool
    func delete() -> Bool
}






