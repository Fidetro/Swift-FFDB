//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

// MARK: - CUSTOM


import Foundation



extension FFObject {
    
    public static  func tableName() -> String {
        let tableName = self.className().replacingOccurrences(of: ".Type", with: "")
        return tableName
    }
    
}

// MARK: - sql
extension FFObject {
    
    public static func select(where condition:String?=nil,
                              values:[Any]?=nil,
                              orderBy orderCondition:String?=nil,
                              orderByType:OrderByType?=nil) -> [FFObject]? {
        do {
            return try FFDBManager.select(self, nil, where: condition, values: values, order: nil) as? [FFObject]
        } catch {
            printDebugLog("failed: \(error.localizedDescription)")
            return nil
        }
    }
    
    @discardableResult
    public static func delete(where condition:String?=nil,
                              values:[Any]?=nil) -> Bool {
        do {
            return try FFDBManager.delete(self, where: condition, values: values)
        } catch  {
            printDebugLog("failed: \(error.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    public static func insert(_ columns:[String],
                              values:[Any]) -> Bool {
        do {
            return try FFDBManager.insert(self, columns, values: values)
        } catch {
            printDebugLog("failed: \(error.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    public static func update(set setFormat:String,
                              where condition:String?,
                              values:[Any]?=nil) -> Bool {
        do {
            return try FFDBManager.update(self, set: setFormat, where: condition, values: values)
        } catch  {
            printDebugLog("failed: \(error.localizedDescription)")
            return false
        }
    }
    
    @discardableResult
    public func insert() -> Bool {
        do {
            return try FFDBManager.insert(self)
        } catch {
            printDebugLog("failed: \(error.localizedDescription)")
            return false
        }
    }
    
    
    public static func registerTable() {
        let createResult = FFDBManager.create(self)
        let alterResult = FFDBManager.alter(self)
        if createResult == true,alterResult == true {
        }else{
            assertionFailure("register fail")
        }
    }
}

extension FFObject {
    
    public  var subType: FFObject.Type {
        let mirror  = Mirror(reflecting: self)
        return mirror.subjectType as! FFObject.Type
    }
    public static func columnsType() -> [String:String] {
        var columnsType = [String:String]()
        let selfProtocol = self.init();
        let mirror  = Mirror(reflecting: selfProtocol)
        for case let (label?, value) in mirror.children {
            
            let valueMirror  = Mirror(reflecting: value)
            switch valueMirror.subjectType {
            case is Data.Type:
                columnsType[label] = "blob"
            case is Optional<Data>.Type:
                columnsType[label] = "blob"
            case is Date.Type:
                columnsType[label] = "double"
            case is Optional<Date>.Type:
                columnsType[label] = "double"
            case is String.Type:
                columnsType[label] = "text"
            case is Optional<String>.Type:
                columnsType[label] = "text"
            case is Float.Type:
                columnsType[label] = "float"
            case is Optional<Float>.Type:
                columnsType[label] = "float"
            case is Float32.Type:
                columnsType[label] = "float"
            case is Optional<Float32>.Type:
                columnsType[label] = "float"
            case is Float64.Type:
                columnsType[label] = "float"
            case is Optional<Float64>.Type:
                columnsType[label] = "float"
                // check https://forums.developer.apple.com/thread/5026
                //            case is Float80.Type:
                //                columnsType[label] = "float"
                //                break
                //            case is Optional<Float80>.Type:
                //                columnsType[label] = "float"
                //                break
                
            case is Double.Type:
                columnsType[label] = "double"
            case is Optional<Double>.Type:
                columnsType[label] = "double"
            case is Int.Type:
                columnsType[label] = "integer"
            case is Optional<Int>.Type:
                columnsType[label] = "integer"
            case is Int8.Type:
                columnsType[label] = "integer"
            case is Optional<Int8>.Type:
                columnsType[label] = "integer"
            case is Int16.Type:
                columnsType[label] = "integer"
            case is Optional<Int16>.Type:
                columnsType[label] = "integer"
            case is Int32.Type:
                columnsType[label] = "integer"
            case is Optional<Int32>.Type:
                columnsType[label] = "integer"
            case is Int64.Type:
                columnsType[label] = "integer"
            case is Optional<Int64>.Type:
                columnsType[label] = "integer"
            case is Bool.Type:
                columnsType[label] = "integer"
            case is Optional<Bool>.Type:
                columnsType[label] = "Bool"
            default:
                columnsType[label] = "text"
            }
            
        }
        return columnsType
    }
    public  static func columnsOfSelf() -> Array<String> {
        var columns = self.propertyOfSelf()
        var newColumns = [String]()
        
        if let memoryPropertys = memoryPropertys() {
            for memoryProperty in memoryPropertys {
                if let index = columns.index(of: memoryProperty) {
                    columns.remove(at: index)
                }
            }
        }
        
        columns = columns.filter{
            $0 == primaryKeyColumn() ? false : true
        }
        
        if let customColumns = customColumns()   {
            for column in columns {
                let customColumn = customColumns[column]
                if let customColumn = customColumn {
                    newColumns.append(customColumn)
                }else{
                    newColumns.append(column)
                }
            }
        }else{
            newColumns = columns
        }
        
        
        return newColumns
    }
    func allValue() -> Array<String> {
        let mirror = Mirror(reflecting: self)
        var values = Array<String>()
        for case let (key?, value) in mirror.children {
            if key == self.subType.primaryKeyColumn() {
                continue
            }
            values.append(anyToString(value))
        }
        
        return values
    }
    
    public   func valueNotNullFrom(_ key: String) -> String {
        if let value = valueFrom(key) {
            return anyToString(value)
        }else{
            return ""
        }
    }
}



extension FIDRuntime {
    
    
    public  var subType: Any.Type {
        let mirror  = Mirror(reflecting: self)
        return mirror.subjectType
    }
    
    fileprivate static func propertyOfSelf() -> Array<String> {
        let selfProtocol = self.init();
        let mirror  = Mirror(reflecting: selfProtocol)
        var propertys = Array<String>()
        
        for case let (label?, _) in mirror.children {
            propertys.append(label)
        }
        return propertys
    }
    fileprivate static  func className() -> String {
        let mirror  = Mirror(reflecting: self)
        return String(describing: mirror.subjectType)
    }
    
    public  func valueFrom(_ key: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            if label == key {
                return value
            }
        }
        return nil
    }
    func allValue() -> Array<String> {
        let mirror = Mirror(reflecting: self)
        var values = Array<String>()
        for case let (_, value) in mirror.children {
            values.append(anyToString(value))
        }
        
        return values
    }
}


func anyToString(_ describing:Any) -> String {
    let mirror  = Mirror(reflecting: describing)
    switch mirror.subjectType {
    case is Date.Type:
        let date = describing as! Date
        return "\(date.timeIntervalSince1970)"
    case is Optional<Date>.Type:
        guard let date = describing as? Date else{
            return "\(Date().timeIntervalSince1970)"
        }
        return "\(date.timeIntervalSince1970)"
    case is Optional<Float>.Type:
        guard let value = describing as? Float else{
            return "0"
        }
        return "\(value)"
    case is Optional<Float64>.Type:
        guard let value = describing as? Float64 else{
            return "0"
        }
        return "\(value)"
    case is Optional<Float32>.Type:
        guard let value = describing as? Float32 else{
            return "0"
        }
        return "\(value)"
    case is Optional<Double>.Type:
        guard let value = describing as? Double else{
            return "0"
        }
        return "\(value)"
    case is Optional<Int>.Type:
        guard let value = describing as? Int else{
            return "0"
        }
        return "\(value)"
    case is Optional<Int8>.Type:
        guard let value = describing as? Int8 else{
            return "0"
        }
        return "\(value)"
    case is Optional<Int16>.Type:
        guard let value = describing as? Int16 else{
            return "0"
        }
        return "\(value)"
    case is Optional<Int32>.Type:
        guard let value = describing as? Int32 else{
            return "0"
        }
        return "\(value)"
    case is Optional<Int64>.Type:
        guard let value = describing as? Int64 else{
            return "0"
        }
        return "\(value)"
    case is Optional<Bool>.Type:
        guard let value = describing as? Bool else{
            return "false"
        }
        return value == true ? "true" : "false"
    case is Bool.Type:
        guard let value = describing as? Bool else{
            return "false"
        }
        return value == true ? "true" : "false"
    default:
        switch String(describing: describing)
        {
        case "nil":
            return ""
        case "Optional(nil)":
            return ""
        default :
            #if os(iOS)
            let value : AnyObject? = (describing as AnyObject)
            if value != nil {
                return String(describing: value!)
            }else{
                return ""
            }
            #else
            return String(describing: describing)
            #endif
        }
    }
    
    
}
