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
    public  static func select(where condition:String?) -> Array<FFObject>? {
        return (FFDBManager.select(self, nil, where: condition) as! Array<FFObject>?)
    }
    public func insert() -> Bool {
        return FFDBManager.insert(self)
    }
    public  func update() -> Bool {
        return FFDBManager.update(self, set: nil)
    }
    public  func update(set condition:String) -> Bool {
        if let primaryID = self.primaryID  {
            return FFDBManager.update(self.subType, set: condition, where: "primaryID = '\(primaryID)'")
        }else{
            assertionFailure("primaryID is nil")
            return false
        }
        
    }
    public  func delete() -> Bool {
        return FFDBManager.delete(self)
    }
    public   static func registerTable() {
        let createResult = FFDBManager.create(self)
        let alterResult = FFDBManager.alter(self)
        if createResult == true && alterResult == true {
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
            #if os(Linux)
                
            #else
                switch valueMirror.subjectType {
                case is Date.Type:
                    columnsType[label] = "double"
                    continue
                case is Optional<Date>.Type:
                    columnsType[label] = "double"
                    continue
                default:
                    break
                }
            #endif
            switch valueMirror.subjectType {
                
                
                
            case is String.Type:
                columnsType[label] = "text"
                break
            case is Optional<String>.Type:
                columnsType[label] = "text"
                break
                
            case is Float.Type:
                columnsType[label] = "float"
                break
            case is Optional<Float>.Type:
                columnsType[label] = "float"
                break
            case is Float32.Type:
                columnsType[label] = "float"
                break
            case is Optional<Float32>.Type:
                columnsType[label] = "float"
                break
            case is Float64.Type:
                columnsType[label] = "float"
                break
            case is Optional<Float64>.Type:
                columnsType[label] = "float"
                break
                
                // check https://forums.developer.apple.com/thread/5026
                //            case is Float80.Type:
                //                columnsType[label] = "float"
                //                break
                //            case is Optional<Float80>.Type:
                //                columnsType[label] = "float"
                //                break
                
            case is Double.Type:
                columnsType[label] = "double"
                break
            case is Optional<Double>.Type:
                columnsType[label] = "double"
                break
            case is Int.Type:
                columnsType[label] = "integer"
                break
            case is Optional<Int>.Type:
                columnsType[label] = "integer"
                break
            case is Int8.Type:
                columnsType[label] = "integer"
                break
            case is Optional<Int8>.Type:
                columnsType[label] = "integer"
                break
            case is Int16.Type:
                columnsType[label] = "integer"
                break
            case is Optional<Int16>.Type:
                columnsType[label] = "integer"
                break
            case is Int32.Type:
                columnsType[label] = "integer"
                break
            case is Optional<Int32>.Type:
                columnsType[label] = "integer"
                break
            case is Int64.Type:
                columnsType[label] = "integer"
                break
            case is Optional<Int64>.Type:
                columnsType[label] = "integer"
                break
            default:
                columnsType[label] = "text"
                break
            }
        }
        return columnsType
    }
    public  static func columnsOfSelf() -> Array<String> {
        var columns = self.propertyOfSelf()
        var newColumns = [String]()
        if let index = columns.index(of: "primaryID") {
            columns.remove(at: index)
        }
        if let memoryPropertys = memoryPropertys() {
            for memoryProperty in memoryPropertys {
                if let index = columns.index(of: memoryProperty) {
                    columns.remove(at: index)
                }
            }
        }
        if let customColumns = customColumns()   {
            for column in columns {
                let customColumn = customColumns[column]
                if customColumn != nil {
                    newColumns.append(customColumn!)
                }else{
                    newColumns.append(column)
                }
            }
        }else{
            newColumns = columns
        }
        
        
        return newColumns
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
        var values = Array<String>();
        for case let (key?, value) in mirror.children {
            if key == "primaryID" {
                continue;
            }
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
    case is Optional<String>.Type:
        guard let value = describing as? String else{
            return ""
        }
        return "\(value)"
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
