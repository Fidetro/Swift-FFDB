//
//  FMDBConnection.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/14.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



import FMDB



public struct FMDBConnection:FFDBConnection {
    
    public typealias T = FMDatabase
    
    public static let share = FMDBConnection()
    
    public var databasePath : String?
    
    
    
    private init() {}
    
    public func executeDBQuery<R:Decodable>(return type: R.Type,
                                            sql: String,
                                            values: [Any]?,
                                            completion: QueryResult?) throws {
        try database().executeDBQuery(return: type, sql: sql, values: values, completion: completion)
    }
    
    public func executeDBUpdate(sql: String,
                                values: [Any]?,
                                completion: UpdateResult?) throws {
        try database().executeDBUpdate(sql: sql, values: values, completion: completion)
    }
    
    
    
    
    /// Get databaseContentFileURL
    ///
    /// - Returns: databaseURL
    public func databasePathURL() -> URL {
        let executableFile = databasePath ?? (Bundle.main.object(forInfoDictionaryKey: kCFBundleExecutableKey as String)  as! String)
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(executableFile)
        return fileURL
    }
    
    public func database() -> T {
        
        let database = FMDatabase(url: databasePathURL())
        return database
    }
    public func findNewColumns(_ table:FFObject.Type) -> [String]? {
        var newColumns = [String]()
        for column in table.columnsOfSelf() {
            
            let result = columnExists(column, inTableWithName: table.tableName())
            if result == false {
                newColumns.append(column)
            }
        }
        guard newColumns.count != 0 else {
            return nil
        }
        return newColumns
    }
    
    private func columnExists(_ columnName: String, inTableWithName: String) -> Bool {
        let database = self.database()
        guard database.open() else {
            printDebugLog("Unable to open database")
            return false
        }
        let result = database.columnExists(columnName, inTableWithName: inTableWithName)
        return result
    }
}

extension FMDatabase {
    
    func executeDBUpdate(sql:String,values:[Any]?,completion:UpdateResult?) throws {
        guard open() else {
            printDebugLog("Unable to open database")
            if let completion = completion { completion(false) }
            return
        }
        
        guard var values = values else {
            try self.executeUpdate(sql, values: nil)
            
            if let completion = completion { completion(true) }
            return
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
        if let completion = completion { completion(true) }
        
        
    }
    
    func executeDBQuery<T:Decodable>(return type:T.Type, sql:String, values:[Any]?,completion: QueryResult?) throws  {
        guard self.open() else {
            printDebugLog("Unable to open database")
            if let completion = completion  { completion(nil) }
            return
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
                    printDebugLog(error)
                    assertionFailure("check you func columntype,func customColumnsType,property type")
                }
                
            }
        }
        
        
        guard modelArray.count != 0 else {
            if let completion = completion  { completion(nil) }
            return
        }
        if let completion = completion  { completion(modelArray) }
    }
    
}

