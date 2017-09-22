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
    
    /// 相当于Objective-C中的valueForKey:
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueFrom(_ key: String) -> Any;
}

protocol FFDataBaseModel:FIDRuntime {
    var primaryID : String? {get}
    
    
    static  func tableName() -> String
    static func columnsOfSelf() -> Array<String>
    
}






