//
//  FFDBManager.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


public struct FFDBManager {
    
}

// MARK: - Insert
extension FFDBManager {
    public static func insert(_ object:FFObject, _ columns:[String]?) -> Bool {
        if let columnsArray = columns {
            var values = Array<Any>()
            for key in columnsArray {
                values.append(object.valueNotNullFrom(key))
            }
            return Insert().into(object.subType).columns(columnsArray).values(values).execute()
            
            
        }else{
            return Insert().into(object.subType).columns(object.subType).values(object).execute()
        }
    }
    public  static func insert(_ object:FFObject) -> Bool {
        return insert(object, nil)
    }
    public  static func insert(_ table:FFObject.Type,_ columns:[String],values:[Any]) -> Bool{
        return Insert().into(table).columns(columns).values(values).execute()
    }
}


// MARK: - Select
extension FFDBManager {
    public  static func select<T:FFObject,U:Decodable>(_ table:T.Type, _ columns:[String]?, where condition:String?, return type:U.Type) -> Array<Decodable>? {
        
        if let format = condition {
            if let col = columns {
                return Select(col).from(table).whereFormat(format).execute(type)
            }else{
                return Select().from(table).whereFormat(format).execute(type)
            }
        }else{
            
            if let col = columns {
                return Select(col).from(table).execute(type)
            }else{
                return Select().from(table).execute(type)
            }
        }
    }
    
    public   static func select<T:FFObject>(_ table:T.Type,_ columns:[String]?,where condition:String?) -> Array<Decodable>? {
        return select(table, columns, where: condition, return: table)
    }
}

// MARK: - Update
extension FFDBManager {
    public static func update(_ object:FFObject,set columns:[String]?) -> Bool {
        if let primaryID = object.primaryID  {
            if let col = columns {
                return Update(object).set(col).whereFormat("primaryID = '\(primaryID)'").execute()
            }else{
                return Update(object).set().whereFormat("primaryID = '\(primaryID)'").execute()
            }
        }else{
            assertionFailure("primaryID can't be nil")
            return false
        }
    }
    public  static func update(_ table:FFObject.Type,set setFormat:String,where whereFormat:String?) -> Bool {
        if let format = whereFormat  {
            return Update(table).set(setFormat).whereFormat(format).execute()
        }else{
            return Update(table).set(setFormat).execute()
        }
    }
}


// MARK: - Delete
extension FFDBManager {
    public  static func delete(_ table:FFObject.Type,where condition:String?) -> Bool{
        if let format = condition {
            return Delete().from(table).whereFormat(format).execute()
        }else{
            return Delete().from(table).execute()
        }
    }
    public   static func delete(_ object:FFObject) -> Bool{
        if let primaryID = object.primaryID {
            return Delete().from(object.subType).whereFormat("primaryID = '\(primaryID)'").execute()
        }else{
            assertionFailure("primaryID can't be nil")
            return false
        }
    }
}

// MARK: - Create
extension FFDBManager {
    static func create(_ table:FFObject.Type) -> Bool {
        return Create(table).execute()
    }
}

// MARK: - Create
extension FFDBManager {
    static func alter(_ table:FFObject.Type) -> Bool {
        return Alter(table).execute()
    }
}

