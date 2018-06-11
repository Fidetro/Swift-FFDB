//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//
import Foundation
func printDebugLog<T>(_ message: T,
                      file: String = #file,
                      method: String = #function,
                      line: Int = #line)
{
    #if DEBUG
    print("\(file)[\(line)], \(method): \(message)")
    #endif
}
public typealias QueryResult = (_ result:[Decodable]?)->()
public typealias UpdateResult = (_ result:Bool)->()

public class FFDB {
    public static var share = FFDB()
    /*
    public enum FFDBType {
        case FMDB
        case SQLiteSwift
    }
    private var type : FFDBType!
    public func setup(_ type:FFDBType) {
        switch type {
        case .FMDB:
            self.type = type
        case .SQLiteSwift:
            self.type = type
        }
    }
    */
    public func connection() -> FMDBConnection {
        return FMDBConnection.share
    }
    
    
}

public protocol FFDBConnection {
    
    associatedtype T
    
    var databasePath : String? {get set}
    
    func database() -> T
    
     func findNewColumns(_ table:FFObject.Type) -> [String]?
    
    func executeDBQuery<R:Decodable>(return type: R.Type,
                                     sql: String,
                                     values: [Any]?,
                                     completion:QueryResult?) throws
    
    func executeDBUpdate(sql: String,
                         values: [Any]?,
                         completion:UpdateResult?) throws
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

    @discardableResult
    func update() -> Bool
    
    @discardableResult
    func delete() -> Bool
    
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
    static func primaryKeyColumn() -> String?
    
    
    static  func tableName() -> String
    
}






