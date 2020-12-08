//
//  FFDBTransaction.swift
//  Swift-FFDB
//
//  Created by Fidetro on 12/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import FMDB

public struct FFDBTransaction {}


// MARK: Insert
extension FFDBTransaction {
    
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
    ///   - isRollback: need rollback when error
    public static func insert(_ object:FFObject,
                              _ columns:[String]? = nil,
                              isRollback:ObjCBool? = false,
                              completion: UpdateResult?)  {
        executeDBUpdate { (db, rollback) in
            do{
                try FFDBManager.insert(object, columns, database: db)
                if let completion = completion { completion(true) }
            }catch{
                if let isRollback = isRollback { rollback.pointee = isRollback }
                if let completion = completion { completion(false) }
                debugPrintLog("failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    /// insert value in table
    ///
    /// - Parameters:
    ///   - table:  FFObject.Type
    ///   - columns: insert columns
    ///   - values: the value of column
    ///   - isRollback: need rollback when error
    public static func insert(_ table:FFObject.Type,
                              _ columns:[String],
                              values:[Any],
                              isRollback:ObjCBool? = false,
                              completion: UpdateResult?) {
        executeDBUpdate { (db, rollback) in
            do{
                try FFDBManager.insert(table, columns, values: values, database: db)
                if let completion = completion { completion(true) }
            }catch{
                if let isRollback = isRollback { rollback.pointee = isRollback }
                if let completion = completion { completion(false) }
                debugPrintLog("failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: Select
extension FFDBTransaction {
    
    
    /// select column from table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - columns: select columns,if columns is nil,return table all columns
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - type: The type of reception
    ///   - isRollback: need rollback when error
    ///   - callBack: return select objects
    public static func select<T:FFObject,U:Decodable>(table:T.Type,
                                                      columns:[String]? = nil,
                                                      where condition:String? = nil,
                                                      values:[Any]? = nil,
                                                      limit: String?=nil,
                                                      return type:U.Type,
                                                      isRollback:ObjCBool? = false,
                                                      completion:QueryResult? = nil) {
        executeDBQuery { (db, rollback) in
            do{
                let objects = try FFDBManager.select(table, columns,
                                                     where: condition,
                                                     values: values,
                                                     order: nil,
                                                     limit: limit,
                                                     return: type,
                                                     database: db)
                if let completion = completion { completion(objects) }
            }catch{
                if let isRollback = isRollback { rollback.pointee = isRollback }
                if let completion = completion { completion(nil) }
                debugPrintLog("failed: \(error.localizedDescription)")
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
    ///   - isRollback: need rollback when error
    ///   - callBack: return select objects
    public static func select<T:FFObject>(table:T.Type,
                                          columns:[String]? = nil,
                                          where condition:String? = nil,
                                          values:[Any]? = nil,
                                          limit: String?=nil,
                                          isRollback:ObjCBool? = false,
                                          completion:QueryResult? = nil)  {
        
        executeDBQuery { (db, rollback) in
            do{
                let objects = try FFDBManager.select(table, columns,
                                                     where: condition,
                                                     values: values,
                                                     order: nil,
                                                     limit: limit,
                                                     database: db)
                if let completion = completion { completion(objects) }
            }catch{
                if let isRollback = isRollback { rollback.pointee = isRollback }
                if let completion = completion { completion(nil) }
                debugPrintLog("failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: Update
extension FFDBTransaction {
    
    
    /// update value of the table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - setFormat: for example,you want to update Person name and age,you can set "name = ?,age = ?"
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - isRollback: need rollback when error
    public static func update(_ table:FFObject.Type,
                              set setFormat:String,
                              where condition:String?,
                              values:[Any]? = nil,
                              isRollback:ObjCBool? = false,
                              completion: UpdateResult?) {
        executeDBUpdate { (db, rollback) in
            do{
                try FFDBManager.update(table, set: setFormat, where: condition, values: values, database: db)
                if let completion = completion { completion(true) }
            }catch{
                if let isRollback = isRollback { rollback.pointee = isRollback }
                if let completion = completion { completion(false) }
                debugPrintLog("failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: Delete
extension FFDBTransaction {
    
    
    /// delete row of the table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - isRollback: need rollback when error
    public static func delete(_ table:FFObject.Type,
                              where condition:String? = nil,
                              values:[Any]? = nil,
                              isRollback:ObjCBool? = false,
                              completion: UpdateResult?) {
        executeDBUpdate { (db, rollback) in
            do{
                try FFDBManager.delete(table, where: condition, values: values, database: db)
                if let completion = completion { completion(true) }
            }catch{
                if let isRollback = isRollback { rollback.pointee = isRollback }
                if let completion = completion { completion(false) }
                debugPrintLog("failed: \(error.localizedDescription)")
            }
        }
    }
    
}

extension FFDBTransaction {
    public static func executeDBQuery(block:((FMDatabase,UnsafeMutablePointer<ObjCBool>)->()))  {
        let queue = FMDatabaseQueue(url: FFDB.share.connection().databasePathURL())
        queue?.inTransaction(block)
    }
    
    
    public static func executeDBUpdate(block:((FMDatabase,UnsafeMutablePointer<ObjCBool>)->())) {
        let queue = FMDatabaseQueue(url: FFDB.share.connection().databasePathURL())
        queue?.inTransaction(block)
    }
}
