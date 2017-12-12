//
//  FMDBConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/14.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



import FMDB
struct FMDBConnect {
    
    init() {}
    
    static func executeDBQuery<T>(return type: T.Type, sql: String, values: [Any]?, shouldClose: Bool) throws -> Array<Decodable>? where T : Decodable {
          return try database().executeDBQuery(return: type, sql: sql, values: values)
    }
    
   
    static func executeDBUpdate(sql: String, values: [Any]?, shouldClose: Bool = true) throws -> Bool {
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
    
    func executeDBUpdate(sql:String,values:[Any]?,shouldClose: Bool) throws -> Bool {
        guard self.open() else {
            printDebugLog("Unable to open database")
            return false
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
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .init(rawValue: 0))
                    do{
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
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

