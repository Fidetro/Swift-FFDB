//
//  FFDBManager.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import FMDB
public struct FFDBManager {}

// MARK: - Insert
extension FFDBManager {
    
    
    
    ///   insert object
    ///
    ///   ````
    ///   let john = Person.init(primaryID: nil, name: "john", age: 10, address: "China")
    ///
    ///   FFDBManager.insert(john) // primaryID = 1,name = "john",age = 10,address = "China"
    ///
    ///   FFDBManager.insert(john,["name","age"]) // primaryID = 1,name = "john",age = 10
    ///   ````
    /// - Parameters:
    ///   - object:  object
    ///   - columns: column name
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: result
    /// - Throws: FMDB error
    @discardableResult public static func insert(_ object:FFObject,
                                                 _ columns:[String]? = nil,
                                                 database db:FMDatabase? = nil) throws -> Bool {
        
        if let columnsArray = columns {
            var values = Array<Any>()
            for key in columnsArray {
                values.append(object.valueNotNullFrom(key))
            }
            return try Insert()
                .into(object.subType)
                .columns(columnsArray)
                .values(values)
                .execute(database: db)
        }else{
            return try Insert()
                .into(object.subType)
                .columns(object.subType)
                .values(object)
                .execute(database: db)
        }
    }
    
    
    /// insert value in table
    ///
    /// - Parameters:
    ///   - table:  FFObject.Type
    ///   - columns: insert columns
    ///   - values: the value of column
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: result
    /// - Throws: FMDB error
    @discardableResult public static func insert(_ table:FFObject.Type,
                                                 _ columns:[String],
                                                 values:[Any],
                                                 database db:FMDatabase? = nil) throws -> Bool {
        return try Insert()
            .into(table)
            .columns(columns)
            .values(values)
            .execute(database: db)
    }
}


// MARK: - Select
extension FFDBManager {
    
    /// select column from table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - columns: select columns,if columns is nil,return table all columns
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - type: The type of reception
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: return select objects
    /// - Throws: FMDB error
    public static func select<T:FFObject,U:Decodable>(_ table:T.Type,
                                                      _ columns:[String]? = nil,
                                                      where condition:String? = nil,
                                                      values:[Any]? = nil,
                                                      orderBy orderCondition:String? = nil,
                                                      orderByType:OrderByType? = nil,
                                                      return type:U.Type,
                                                      database db:FMDatabase? = nil) throws -> Array<Decodable>? {
        guard let orderCondition = orderCondition, let orderByType = orderByType else {
            if let format = condition {
                if let col = columns {
                    return try Select(col)
                        .from(table)
                        .whereFormat(format)
                        .execute(database: db,type, values: values)
                }else{
                    return try Select()
                        .from(table)
                        .whereFormat(format)
                        .execute(database: db,type, values: values)
                }
            }else{
                if let col = columns {
                    return try Select(col)
                        .from(table)
                        .execute(database: db,type, values: values)
                }else{
                    return try Select()
                        .from(table)
                        .execute(database: db,type, values: values)
                }
            }
        }
        if let format = condition {
            if let col = columns {
                return try Select(col)
                    .from(table)
                    .whereFormat(format)
                    .order(by: orderCondition, orderByType)
                    .execute(database: db,type, values: values)
            }else{
                return try Select()
                    .from(table)
                    .whereFormat(format)
                    .order(by: orderCondition, orderByType)
                    .execute(database: db,type, values: values)
            }
        }else{
            if let col = columns {
                return try Select(col)
                    .from(table)
                    .order(by: orderCondition, orderByType)
                    .execute(database: db,type, values: values)
            }else{
                return try Select()
                    .from(table)
                    .order(by: orderCondition, orderByType)
                    .execute(database: db,type, values: values)
            }
        }
    }
    
    /// select column from table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - columns: select columns,if columns is nil,return table all columns
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: return select objects
    /// - Throws: FMDB error
    public static func select<T:FFObject>(_ table:T.Type,
                                          _ columns:[String]? = nil,
                                          where condition:String? = nil,
                                          values:[Any]? = nil,
                                          orderBy orderCondition:String? = nil,
                                          orderByType:OrderByType? = nil,
                                          database db:FMDatabase? = nil) throws -> Array<Decodable>? {
        
        return try select(table, columns,
                          where: condition,
                          values: values,
                          orderBy: orderCondition,
                          orderByType: orderByType,
                          return: table,
                          database: db)
    }
}

// MARK: - Update
extension FFDBManager {
    
    /// update value by columns,you can custom set columns to update
    ///
    /// - Parameters:
    ///   - object: object
    ///   - columns: set columns to update,if columns is nil,it will be update all property
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: result
    /// - Throws: FMDB error
    @discardableResult
    public static func update(_ object:FFObject,
                                                 set columns:[String]? = nil,
                                                 database db:FMDatabase? = nil) throws -> Bool {
        if let primaryID = object.primaryID  {
            if let col = columns {
                return try Update(object)
                    .set(col)
                    .whereFormat("primaryID = '\(primaryID)'")
                    .execute(database: db,values: nil)
            }else{
                return try Update(object)
                    .set()
                    .whereFormat("primaryID = '\(primaryID)'")
                    .execute(database: db,values: nil)
            }
        }else{
            assertionFailure("primaryID can't be nil")
            return false
        }
        
    }
    
    
    /// update value of the table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - setFormat: for example,you want to update Person name and age,you can set "name = ?,age = ?"
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: result
    /// - Throws: FMDB error
    @discardableResult
    public static func update(_ table:FFObject.Type,
                                                 set setFormat:String,
                                                 where condition:String?,
                                                 values:[Any]? = nil,
                                                 database db:FMDatabase? = nil) throws -> Bool {
        if let condition = condition  {
            return try Update(table)
                .set(setFormat)
                .whereFormat(condition)
                .execute(database: db,values: values)
        }else{
            return try Update(table)
                .set(setFormat)
                .execute(database: db,values: values)
        }
    }
}


// MARK: - Delete
extension FFDBManager {
    
    /// delete row of the table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: result
    /// - Throws: FMDB error
    @discardableResult
    public static func delete(_ table:FFObject.Type,
                                                 where condition:String? = nil,
                                                 values:[Any]? = nil,
                                                 database db:FMDatabase? = nil) throws -> Bool {
        if let format = condition {
            return try Delete()
                .from(table)
                .whereFormat(format)
                .execute(database: db,values: values)
        }else{
            return try Delete()
                .from(table)
                .execute(database: db,values: values)
        }
    }
    
    
    
    /// delete object of the table
    ///
    /// - Parameters:
    ///   - object: object
    ///   - db: set database when use SafeOperation or Transaction,it should be alway nil
    /// - Returns: result
    /// - Throws: FMDB error
    @discardableResult
    public static func delete(_ object:FFObject,
                                                 database db:FMDatabase? = nil) throws -> Bool {
        if let primaryID = object.primaryID {
            return try Delete()
                .from(object.subType)
                .whereFormat("primaryID = '\(primaryID)'")
                .execute(database: db,values: nil)
        }else{
            assertionFailure("primaryID can't be nil")
            return false
        }
    }
}

// MARK: - Create
extension FFDBManager {
    static func create(_ table:FFObject.Type) -> Bool {
        do {
            return try Create(table).execute()
        } catch  {
            printDebugLog("failed: \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - Alter
extension FFDBManager {
    static func alter(_ table:FFObject.Type) -> Bool {
        do {
            return try Alter(table).execute()
        } catch  {
            printDebugLog("failed: \(error.localizedDescription)")
            return false
        }
    }
}

