//
//  FMDBConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/14.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



import FMDB
struct FMDBConnect:FFDBConnect {
    static func executeDBQuery<T>(return type: T.Type, sql: String, values: [Any]?, shouldClose: Bool) -> Array<Decodable>? where T : Decodable {
          return database().executeDBQuery(return: type, sql: sql, values: values)
    }
    
   
    static func executeDBUpdate(sql: String, values: [Any]?, shouldClose: Bool = true) -> Bool {
        return database().executeDBUpdate(sql: sql, values: values, shouldClose: shouldClose)
    }
        


    init() {}
 
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
    
    func executeDBUpdate(sql:String,values:[Any]?,shouldClose: Bool) -> Bool {
        guard self.open() else {
            printDebugLog("Unable to open database")
            return false
        }
        do {
            try self.executeUpdate(sql, values: values)
            if shouldClose == true {
                self.close()
            }
            return true
        } catch {
            printDebugLog("failed: \(error.localizedDescription)")
        }
        return false
    }

    func executeDBQuery<T:Decodable>(return type:T.Type, sql:String, values:[Any]?,shouldClose: Bool? = true) -> Array<Decodable>? {
        guard self.open() else {
            printDebugLog("Unable to open database")
            return nil
        }
        
        do {
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
            
        } catch {
            self.close()
            printDebugLog("failed: \(error.localizedDescription)")
        }
        return nil
    }
    
}

