//
//  FMDBConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/14.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

func printDebugLog<T>(_ message: T,
                      file: String = #file,
                      method: String = #function,
                      line: Int = #line)
{
    #if DEBUG
    print("\(file)[\(line)], \(method): \(message)")
    #endif
}
public class FFDB {
    public static var share = FFDB()
    public enum FFDBType {
        case FMDB
    }
    private var type : FFDBType!
    
    public func setup(_ type:FFDBType) {
        switch type {
        case .FMDB:
            self.type = type
        }
    }
    
    public static func connection() -> FFDBConnection {
        return FMDBConnection.share
    }
    
}


import FMDB

public protocol FFDBConnection {
    
    associatedtype T
    static func database() -> T
}

struct FMDBConnection:FFDBConnection {
    static let share = FMDBConnection()
    typealias T = FMDatabase
    
    
     init() {}
    
    static func executeDBQuery<T>(return type: T.Type, sql: String, values: [Any]?, shouldClose: Bool?=true) throws -> Array<Decodable>? where T : Decodable {
        return try database().executeDBQuery(return: type, sql: sql, values: values, shouldClose: shouldClose)
    }
    
    
    static func executeDBUpdate(sql: String, values: [Any]?, shouldClose: Bool?=true) throws -> Bool {
        return try database().executeDBUpdate(sql: sql, values: values, shouldClose: shouldClose)
    }
    
    
    /// Get databaseContentFileURL
    ///
    /// - Returns: databaseURL
    static func databasePath() -> URL? {
        if let executableFile = Bundle.main.object(forInfoDictionaryKey: kCFBundleExecutableKey as String) {
            let fileURL = try! FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(executableFile as! String)
            return fileURL
        }
        return nil
    }
    
    static func database() -> FMDatabase {
        let database = FMDatabase(url: databasePath())
        return database
    }
    
    static func columnExists(_ columnName: String, inTableWithName: String) -> Bool {
        let database = self.database()
        guard database.open() else {
            printDebugLog("Unable to open database")
            return false
        }
        let result = database.columnExists(columnName, inTableWithName: inTableWithName)
        database.close()
        return result
    }
}

extension FMDatabase {
    
    func executeDBUpdate(sql:String,values:[Any]?,shouldClose: Bool?=true) throws -> Bool {
        guard self.open() else {
            printDebugLog("Unable to open database")
            return false
        }
        
        guard var values = values else {
            try self.executeUpdate(sql, values: nil)
            if shouldClose == true {
                self.close()
            }
            return true
        }
        
        
        values = values.map { (ele) -> Any in
            if let data = ele as? Data {
                return data.base64EncodedString()
            }else if let json = ele as? [String:Any] {
                do{
                    return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted).base64EncodedString()
                }catch{
                    printDebugLog("\(error)")
                    assertionFailure()
                }
            }
            return ele
        }
        
        try self.executeUpdate(sql, values: values)
        if shouldClose == true {
            self.close()
        }
        return true
        
        
    }
    
    func executeDBQuery<T:Decodable>(return type:T.Type, sql:String, values:[Any]?,shouldClose: Bool? = true) throws -> Array<Decodable>? {
        guard self.open() else {
            printDebugLog("Unable to open database")
            return nil
        }
        
        let result = try self.executeQuery(sql, values: values)
        var modelArray = Array<Decodable>()
        while result.next() {
            if let dict =  result.resultDictionary {
                
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                do{
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    decoder.dataDecodingStrategy = .base64
                    let model = try decoder.decode(type, from: jsonData)
                    modelArray.append(model)
                }catch{
                    self.close()
                    printDebugLog(error)
                    assertionFailure("check you func columntype,func customColumnsType,property type")
                }
                
            }
        }
        
        if shouldClose == true {
            self.close()
        }
        
        guard modelArray.count != 0 else {
            return nil
        }
        return modelArray
    }
    
}

