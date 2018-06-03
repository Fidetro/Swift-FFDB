//
//  FFDBSafeOperation.swift
//  Swift-FFDB
//
//  Created by Fidetro on 11/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//

import FMDB
public struct FFDBSafeOperation {}


// MARK: Insert
extension FFDBSafeOperation {
    
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
    public static func insert(_ object:FFObject,
                              _ columns:[String]? = nil)  {
        
        
        let queue = FMDatabaseQueue.init(url: FFDB.share.connection().databasePathURL())
        queue.inDatabase { (db) in
            do{
                try FFDBManager.insert(object, columns, database: db)
            }catch{
                printDebugLog("failed: \(error.localizedDescription)")
            }
        }
    }
    
    /// insert value in table
    ///
    /// - Parameters:
    ///   - table:  FFObject.Type
    ///   - columns: insert columns
    ///   - values: the value of column
    public static func insert(_ table:FFObject.Type,
                              _ columns:[String],
                              values:[Any]) {
        let queue = FMDatabaseQueue.init(url: FFDB.share.connection().databasePathURL())
        queue.inDatabase { (db) in
            do{
                try FFDBManager.insert(table, columns, values: values, database: db)
            }catch{
                printDebugLog("failed: \(error.localizedDescription)")
            }
            
        }
    }
}

// MARK: Select
extension FFDBSafeOperation {
    
    
    /// select column from table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - columns: select columns,if columns is nil,return table all columns
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    ///   - type: The type of reception
    ///   - callBack: return select objects
    public static func select<T:FFObject,U:Decodable>(table:T.Type,
                                                      columns:[String]? = nil,
                                                      where condition:String? = nil,
                                                      values:[Any]? = nil,
                                                      return type:U.Type,
                                                      callBack:QueryResult? = nil) {
        let queue = FMDatabaseQueue.init(url: FFDB.share.connection().databasePathURL())
        queue.inDatabase { (db) in
            do{
                let objects = try FFDBManager.select(table, columns,
                                                     where: condition,
                                                     values: values,
                                                     order: nil,
                                                     return: type,
                                                     database: db)
                if let callback = callBack {
                    callback(objects)
                }
            }catch{
                printDebugLog("failed: \(error.localizedDescription)")
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
    ///   - callBack: return select objects
    public static func select<T:FFObject>(table:T.Type,
                                          columns:[String]? = nil,
                                          where condition:String? = nil,
                                          values:[Any]? = nil,
                                          callBack:QueryResult? = nil) {
        let queue = FMDatabaseQueue.init(url: FFDB.share.connection().databasePathURL())
        queue.inDatabase { (db) in
            do{
                let objects = try FFDBManager.select(table, columns,
                                                     where: condition,
                                                     values: values,
                                                     order: nil,
                                                     database: db)
                if let callback = callBack {
                    callback(objects)
                }
            }catch{
                printDebugLog("failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: Update
extension FFDBSafeOperation {
    
    
    /// update value of the table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - setFormat: for example,you want to update Person name and age,you can set "name = ?,age = ?"
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    public static func update(_ table:FFObject.Type,
                              set setFormat:String,
                              where condition:String?,
                              values:[Any]? = nil) {
        let queue = FMDatabaseQueue.init(url: FFDB.share.connection().databasePathURL())
        queue.inDatabase { (db) in
            do{
                try FFDBManager.update(table, set: setFormat, where: condition, values: values, database: db)
            }catch{
                printDebugLog("failed: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: Delete
extension FFDBSafeOperation {
    
    /// delete row of the table
    ///
    /// - Parameters:
    ///   - table: table of FFObject.Type
    ///   - condition: for example, "age > ? and address = ? "
    ///   - values: use params query
    public static func delete(_ table:FFObject.Type,
                              where condition:String? = nil,
                              values:[Any]? = nil) {
        let queue = FMDatabaseQueue.init(url: FFDB.share.connection().databasePathURL())
        queue.inDatabase { (db) in
            do{
                try FFDBManager.delete(table, where: condition, values: values, database: db)
            }catch{
                printDebugLog("failed: \(error.localizedDescription)")
            }
        }
    }
    

}
