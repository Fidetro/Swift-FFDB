//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//
func printDebugLog<T>(_ message: T,
                      file: String = #file,
                      method: String = #function,
                      line: Int = #line)
{
    #if DEBUG
        print("\(file)[\(line)], \(method): \(message)")
    #endif
}
public struct FFDB {
    static var connect = FMDBConnect.self
}



public protocol FIDRuntime {
    init()
    
    /// 获取对象类型
    var subType : Any.Type {get}
    
    /// like Objective-C - (void)valueForKey
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueFrom(_ key: String) -> Any?
}

public protocol FFObject:FIDRuntime,Decodable {
    
    var primaryID : Int64? {get}
    
    static func registerTable()
    static func select(where condition:String?,values:[Any]?) -> Array<FFObject>?
    @discardableResult func insert() -> Bool
    @discardableResult func update() -> Bool
    @discardableResult func update(set condition:String,values:[Any]?) -> Bool
    @discardableResult func delete() -> Bool
    static func columnsType() -> [String:String]
    
    /// like Objective-C - (void)valueForKey: but alway return isn't nil
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueNotNullFrom(_ key: String) -> String
    static func columnsOfSelf() -> Array<String>
    static func memoryPropertys() -> [String]?
    static func customColumnsType() -> [String:String]?
    static func customColumns() -> [String:String]?
    static  func tableName() -> String
}






