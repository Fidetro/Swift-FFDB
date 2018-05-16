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

// MARK: - SQL excute
extension FFDBManager {
    public static func executeDBQuery<T>(return type: T.Type, sql: String, values: [Any]?) throws -> Array<Decodable>? where T : Decodable {
        
        return try FFDB.connect.executeDBQuery(return: type, sql: sql, values: values)
    }
    
    
    public static func executeDBUpdate(sql: String, values: [Any]?) throws -> Bool {
        return try FFDB.connect.executeDBUpdate(sql: sql, values: values)
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



extension FFDBManager {
    public static func newUUID() -> String? {
        let theUUID = CFUUIDCreate(kCFAllocatorDefault)
        let UUID = CFUUIDCreateString(kCFAllocatorDefault, theUUID)        
        return UUID as String?
    }
}
