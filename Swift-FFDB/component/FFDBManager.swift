//
//  FFDBManager.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

struct FFDBManager {
    
}

// MARK: - Insert
extension FFDBManager {
    static func insert(_ object:FFObject, _ columns:[String]?) {
        if let columnsArray = columns {
            var values = Array<Any>()
            for key in columnsArray {
                values.append(object.valueNotNullFrom(key))
            }
            print(Insert().into(object.subType).columns(columnsArray).values(values).sqlStatement!)
        }else{
            print(Insert().into(object.subType).columns(object.subType).values(object).sqlStatement!)
        }
    }
    static func insert(_ object:FFObject) {
            print(insert(object, nil))
    }
    static func insert(_ table:FFObject.Type,_ columns:[String],values:[Any]) {
        print(Insert().into(table).columns(columns).values(values).sqlStatement!)
    }
}


// MARK: - Select
extension FFDBManager {
    
    static func select(_ table:FFObject.Type,_ columns:[String]?,where condition:String?) {
        if let format = condition {
            if let col = columns {
                print(Select(col).from(table).whereFormat(format).sqlStatement!)
            }else{
                print(Select().from(table).whereFormat(format).sqlStatement!)
            }
        }else{
            if let col = columns {
                print(Select(col).from(table).sqlStatement!)
            }else{
                print(Select().from(table).sqlStatement!)
            }
        }
    }
    
}

// MARK: - Update
extension FFDBManager {
    static func update(_ object:FFObject,set columns:[String]?) {
        if let primaryID = object.primaryID  {
            if let col = columns {
                print(Update(object).set(col).whereFormat("primaryID = '\(primaryID)'").sqlStatement!)
            }else{
                print(Update(object).set().whereFormat("primaryID = '\(primaryID)'").sqlStatement!)
            }
        }else{
            assertionFailure("primaryID can't be nil")
        }
    }
    static func update(_ table:FFObject.Type,set setFormat:String,where whereFormat:String?) {
        if let format = whereFormat  {
            print(Update(table).set(setFormat).whereFormat(format).sqlStatement!)
        }else{
            print(Update(table).set(setFormat).sqlStatement!)
        }
    }
}


// MARK: - Delete
extension FFDBManager {
    static func delete(_ table:FFObject.Type,where condition:String?) {
        if let format = condition {
            print(Delete().from(table).whereFormat(format).sqlStatement!)
        }else{
            print(Delete().from(table).sqlStatement!)
        }
    }
    static func delete(_ object:FFObject) {
        if let primaryID = object.primaryID {
            print(Delete().from(object.subType).whereFormat("primaryID = '\(primaryID)'").sqlStatement!)
        }else{
            assertionFailure("primaryID can't be nil")
        }
    }
}
