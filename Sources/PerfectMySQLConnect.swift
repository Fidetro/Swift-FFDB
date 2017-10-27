//
//  PerfectMySQLConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#if os(iOS)
#else
    import PerfectMySQL
    import Foundation
    public struct PerfectMySQLConnect :FFDBConnect {
        
        public  let host : String
        public  let user : String
        public  let password : String
        public  let db  : String
        
        public static var mysql: MySQL = {
            let mysql = MySQL()
            return mysql
        }()
        
        public init(host: String, user: String, password: String, db: String) {
            self.host = host
            self.user = user
            self.password = password
            self.db = db
        }
        
        public func setup(complete:(MySQL) -> ()) {
            
            let setOptionSuccess = PerfectMySQLConnect.mysql.setOption(.MYSQL_SET_CHARSET_NAME, "utf8")
            guard setOptionSuccess else {
                printDebugLog("set UTF-8 fail")
                return
            }
            
            let connected = PerfectMySQLConnect.mysql.connect(host: self.host, user: self.user, password: self.password, db: self.db)
            
            guard connected else {
                printDebugLog(PerfectMySQLConnect.mysql.errorMessage())
                return
            }
            
            defer {
                
            }
            
            complete(PerfectMySQLConnect.mysql)
        }
        
        public static func columnExists(_ columnName: String, inTableWithName: String) -> Bool {
            let stmt = MySQLStmt(mysql)
            let sql = "select * from \(inTableWithName)"
            let prepareSuccess = stmt.prepare(statement:sql)
            guard prepareSuccess else {
                printDebugLog(mysql.errorMessage())
                return false
            }
            let fieldNames = stmt.fieldNames()
            stmt.close()
            return fieldNames.values.contains(columnName)
        }
        
        
        
        public static func executeDBUpdate(sql: String) -> Bool {
            
            let querySuccess = PerfectMySQLConnect.mysql.query(statement: sql)
            guard querySuccess else {
                printDebugLog(sql + PerfectMySQLConnect.mysql.errorMessage())
                return false
            }
            
            
            return true
        }
        
        
        
        public static func executeDBUpdateAfterClose(sql: String) -> Bool {
            
            let querySuccess = PerfectMySQLConnect.mysql.query(statement: sql)
            guard querySuccess else {
                printDebugLog(sql + PerfectMySQLConnect.mysql.errorMessage())
                return false
            }
            
            return true
        }
        
        public static func executeDBQuery<T>(return type: T.Type, sql: String) -> Array<Decodable>? where T : Decodable {
            let stmt = MySQLStmt(mysql)
            let prepareSuccess = stmt.prepare(statement: sql)
            guard prepareSuccess else {
                printDebugLog(sql + mysql.errorMessage())
                return nil
            }
            let querySuccess = stmt.execute()
            guard querySuccess else {
                printDebugLog(sql + mysql.errorMessage())
                return nil
            }
            let results = stmt.results()
            let fieldNames = stmt.fieldNames()
            var resultArr = [[String:Any?]]()
            
            _ = results.forEachRow { row in
                var resultDict = [String:Any?]()
                for (index,value) in row.enumerated() {
                    let fieldName = fieldNames[index]
                    resultDict[fieldName!] = value
                }
                resultArr.append(resultDict)
            }
            do {
                var modelArray = Array<Decodable>()
                for dict in resultArr {
                    let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .init(rawValue: 0))
                    do{
                        let decoder = JSONDecoder()
                        
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let model = try decoder.decode(type, from: jsonData)
                        modelArray.append(model)
                    }catch{
                        printDebugLog(error.localizedDescription)
                        assertionFailure("check you func columntype,func customColumnsType,property type")
                    }
                }
                stmt.close()
                return modelArray
            } catch  {
                stmt.close()
                printDebugLog(error.localizedDescription)
                
            }
            return nil
        }
    }
#endif

