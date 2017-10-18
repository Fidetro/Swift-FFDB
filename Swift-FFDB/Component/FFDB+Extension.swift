//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

// MARK: - CUSTOM
extension FFObject {
    static  func tableName() -> String {
        let tableName = self.className().replacingOccurrences(of: ".Type", with: "")
        return tableName
    }
    //    static func memoryPropertys() -> [String]? {return nil}
    //    static func columnsType() -> [String:String]? {return nil}
    //    static func customColumns() -> [String:String]? {return nil}
}

// MARK: - sql
extension FFObject {
    static func select(_ condition:String?) -> Array<FFObject>? {
        return (FFDBManager.select(self, nil, where: condition) as! Array<FFObject>?)
    }
    func insert() -> Bool {
        return FFDBManager.insert(self)
    }
    func update() -> Bool {
        return FFDBManager.update(self, set: nil)
    }
    func delete() -> Bool {
        return FFDBManager.delete(self)
    }
    static func registerTable() {
        let createResult = FFDBManager.create(self)
        let alterResult = FFDBManager.alter(self)
        if createResult == true && alterResult == true {
        }else{
            assertionFailure("register fail")
        }
    }
}

extension FFObject {
    
    var subType: FFObject.Type {
        let mirror  = Mirror(reflecting: self)
        return mirror.subjectType as! FFObject.Type
    }
    static func columnsType() -> [String:String] {
        var columnsType = [String:String]()
        let selfProtocol = self.init();
        let mirror  = Mirror(reflecting: selfProtocol)
        for case let (label?, value) in mirror.children {
            
            let valueMirror  = Mirror(reflecting: value)
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
            case is Float80.Type:
                columnsType[label] = "float"
                break
            case is Optional<Float80>.Type:
                columnsType[label] = "float"
                break
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
    static func columnsOfSelf() -> Array<String> {
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
        }
        
        
        return newColumns
    }
    
    func valueNotNullFrom(_ key: String) -> String {
        if let value = valueFrom(key) {
            return valueToNotNull(value)
        }else{
            return ""
        }
    }
}



extension FIDRuntime {
    var subType: Any.Type {
        let mirror  = Mirror(reflecting: self)
        return mirror.subjectType
    }
    func valueToNotNull(_ value:Any) -> String {
        switch String(describing: value)
        {
        case "nil":
            return ""
        case "Optional(nil)":
            return ""
        default :
            let val : AnyObject? = (value as AnyObject)
            if val != nil {
                return String(describing: val!)
            }else{
                return ""
            }
        }
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
    
    func valueFrom(_ key: String) -> Any? {
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
            values.append(valueToNotNull(value))
        }
        
        return values
    }
}
