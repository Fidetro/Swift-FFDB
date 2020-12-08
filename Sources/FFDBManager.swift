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
    @discardableResult
    public static func insert(_ object:FFObject,
                              _ columns:[String]? = nil,
                              database db:FMDatabase? = nil) throws -> Bool {
        var _result = false
        var values = Array<Any>()
        for key in columns ?? object.subType.columnsOfSelf() {
            values.append(object.valueNotNullFrom(key))
        }
        try Insert()
            .into(object.subType)
            .columns(columns ?? object.subType.columnsOfSelf())
            .values(values.count)
            .executeDBUpdate(values: values, completion: { (result) in
                _result = result
            })
        return _result
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
    @discardableResult
    public static func insert(_ table:FFObject.Type,
                              _ columns:[String],
                              values:[Any],
                              database db:FMDatabase? = nil) throws -> Bool {
        var _result = false
         try Insert()
            .into(table)
            .columns(columns)
            .values(columns.count)
            .executeDBUpdate(values: values, completion: { (result) in
                _result = result
            })
        return _result
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
                                                      order orderConditions:[(column:String,orderByType:OrderByType)]?=nil,
                                                      limit :String?=nil,
                                                      return type:U.Type,
                                                      database db:FMDatabase? = nil) throws -> [Decodable]? {
        var _result : [Decodable]?

        guard let orderConditions = orderConditions else {
            if let format = condition {
                if let col = columns {
                     try Select(col)
                        .from(table)
                        .where(format)
                        .limit(limit)
                        .executeDBQuery(return: type, values: values, completion: { (result) in
                            _result = result
                        })
                }else{
                     try Select("*")
                        .from(table)
                        .where(format)
                        .limit(limit)
                        .executeDBQuery(return: type, values: values, completion: { (result) in
                            _result = result
                        })
                }
            }else{
                if let col = columns {
                     try Select(col)
                        .from(table)
                        .limit(limit)
                        .executeDBQuery(return: type, values: values, completion: { (result) in
                            _result = result
                        })
                }else{
                     try Select("*")
                        .from(table)
                        .limit(limit)
                        .executeDBQuery(return: type, values: values, completion: { (result) in
                            _result = result
                        })
                }
            }
            return _result
        }
        if let format = condition {
            if let col = columns {
                 try Select(col)
                    .from(table)
                    .where(format)
                    .orderBy(orderConditions)
                    .limit(limit)
                    .executeDBQuery(return: type, values: values, completion: { (result) in
                        _result = result
                    })
            }else{
                 try Select("*")
                    .from(table)
                    .where(format)
                    .orderBy(orderConditions)
                    .limit(limit)
                    .executeDBQuery(return: type, values: values, completion: { (result) in
                        _result = result
                    })
            }
        }else{
            if let col = columns {
                 try Select(col)
                    .from(table)
                    .orderBy(orderConditions)
                    .limit(limit)
                    .executeDBQuery(return: type, values: values, completion: { (result) in
                        _result = result
                    })
            }else{
                 try Select("*")
                    .from(table)
                    .orderBy(orderConditions)
                    .limit(limit)
                    .executeDBQuery(return: type, values: values, completion: { (result) in
                        _result = result
                    })
            }
        }
        return _result
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
                                          order orderConditions:[(column:String,orderByType:OrderByType)]?=nil,
                                          limit: String?=nil,
                                          database db:FMDatabase? = nil) throws -> Array<Decodable>? {
        
        return try select(table, columns,
                          where: condition,
                          values: values,
                          order: orderConditions,
                          limit: limit,
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
        var _result = false
        if let condition = condition  {
             try Update(table)
                .set(setFormat)
                .where(condition)
                .executeDBUpdate(values: values, completion: { (result) in
                    _result = result
                })
            return _result
        }else{
             try Update(table)
                .set(setFormat)
                .executeDBUpdate(values: values, completion: { (result) in
                    _result = result
                })
            return _result
        }
    }
    
    @discardableResult
    public static func update(_ table:FFObject.Type,
                              set setColumns:[String],
                              where condition:String?,
                              values:[Any]? = nil,
                              database db:FMDatabase? = nil) throws -> Bool {
        var _result = false
        if let condition = condition  {
            try Update(table)
                .set(setColumns)
                .where(condition)
                .executeDBUpdate(values: values, completion: { (result) in
                    _result = result
                })
            return _result
        }else{
            try Update(table)
                .set(setColumns)
                .executeDBUpdate(values: values, completion: { (result) in
                    _result = result
                })
            return _result
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
        var _result = false
        if let format = condition {
             try Delete()
                .from(table)
                .where(format)
                .executeDBUpdate(values: values, completion: { (result) in
                    _result = result
                })
        }else{
             try Delete()
                .from(table)
                .executeDBUpdate(values: values, completion: { (result) in
                    _result = result
                })
        }
        return _result
    }
    
}

// MARK: - Create
extension FFDBManager {
    static func create(_ table:FFObject.Type) -> Bool {
        do {
            var _result = false
             try Create(table).executeDBUpdate(values: nil, completion: { (result) in
                _result = result
            })
            return _result
        } catch  {
            debugPrintLog("failed: \(error.localizedDescription)")
            return false
        }
    }
}

// MARK: - SQL excute
extension FFDBManager {
    public static func executeDBQuery<T:Decodable>(return type: T.Type, sql: String, values: [Any]?) throws -> [Decodable]?  {
        var _result : [Decodable]?
         try FFDB.share.connection().executeDBQuery(return: type, sql: sql, values: values, completion: { (result) in
            _result = result
        })
        return _result
    }
    
    
    @discardableResult
    public static func executeDBUpdate(sql: String, values: [Any]?) throws -> Bool {
        var _result = false
        try FFDB.share.connection().executeDBUpdate(sql: sql, values: values, completion: { (result) in
            _result = result
        })        
        return _result
    }
    
}


// MARK: - Alter
extension FFDBManager {
    static func alter(_ table:FFObject.Type) -> Bool {
        do {
            var _result = false
            guard let newColumns = FFDB.share.connection().findNewColumns(table) else {
                _result = true
                return _result
            }
            for newColumn in newColumns {
                try Alter(table).add(column: newColumn, table: table).executeDBUpdate(values: nil, completion: { (result) in
                    _result = result
                })
                if _result == false {
                    return _result
                }
                
            }
            
            return _result
        } catch  {
            debugPrintLog("failed: \(error.localizedDescription)")
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
