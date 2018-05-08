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
    
    

    static func registerTable()
    static func select(where condition:String?,
                       values:[Any]?,
                       orderBy orderCondition:String?,
                       orderByType:OrderByType?) -> [FFObject]?
    
    @discardableResult
    static func delete(where condition:String?,values:[Any]?) -> Bool
    
    @discardableResult
    static func insert(_ columns:[String],values:[Any]) -> Bool
    
    @discardableResult
    static func update(set setFormat:String,where condition:String?,values:[Any]?) -> Bool
    
    @discardableResult
    func insert() -> Bool

    
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
    static func autoincrementColumn() -> String?
    
    
    static  func tableName() -> String
    
}






