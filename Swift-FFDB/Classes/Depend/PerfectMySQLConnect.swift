//
//  PerfectMySQLConnect.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

#if os(iOS)
#else
import PerfectLib
import PerfectMySQL
import PerfectLogger
import Foundation
struct PerfectMySQLConnect :FFDBConnect {

     let host : String
     let user : String
     let password : String
     let db  : String

    static var mysql: MySQL = {
        let mysql = MySQL()
        return mysql
    }()
    
     func setup(complete:(MySQL) -> ()) {
        
        // 创建一个MySQL连接实例
        //        self.mysql.setOption(MYSQL_SET_CHARSET_NAME, "utf8")
        let setOptionSuccess = PerfectMySQLConnect.mysql.setOption(.MYSQL_SET_CHARSET_NAME, "utf8")
        guard setOptionSuccess else {
            LogFile.error("设置UTF-8失败")
            return
        }
        
        let connected = PerfectMySQLConnect.mysql.connect(host: self.host, user: self.user, password: self.password, db: self.db)
        
        guard connected else {
            LogFile.error(PerfectMySQLConnect.mysql.errorMessage())
            return
        }
        
        defer {
            PerfectMySQLConnect.mysql.close()
        }
        
        complete(PerfectMySQLConnect.mysql)
    }
    
    static func columnExists(_ columnName: String, inTableWithName: String) -> Bool {
        let stmt = MySQLStmt(mysql)
        let sql = "select * from \(inTableWithName)"
        let prepareSuccess = stmt.prepare(statement:sql)
        guard prepareSuccess else {
            LogFile.info("查询错误sql:" + sql)
            LogFile.error(mysql.errorMessage())
            return false
        }
        let fieldNames = stmt.fieldNames()
        stmt.close()
        return fieldNames.values.contains(columnName)
    }
    
    
    
    static func executeDBUpdate(sql: String) -> Bool {
        
        let querySuccess = PerfectMySQLConnect.mysql.query(statement: sql)
        guard querySuccess else {
            LogFile.error(PerfectMySQLConnect.mysql.errorMessage())
            LogFile.error("错误sql" + sql)
            return false
        }
        LogFile.info("执行成功")
        
        return true
    }
    
    
    
    static func executeDBUpdateAfterClose(sql: String) -> Bool {
        let querySuccess = PerfectMySQLConnect.mysql.query(statement: sql)
        guard querySuccess else {
            LogFile.error(PerfectMySQLConnect.mysql.errorMessage())
            LogFile.error("错误sql" + sql)
            return false
        }
        LogFile.info("执行成功")
        
        return true
    }
    
    static func executeDBQuery<T>(return type: T.Type, sql: String) -> Array<Decodable>? where T : Decodable {
        let stmt = MySQLStmt(mysql)
        let prepareSuccess = stmt.prepare(statement: sql)
        guard prepareSuccess else {
            LogFile.info("查询错误sql:" + sql)
            LogFile.error(mysql.errorMessage())
            return nil
        }
        let querySuccess = stmt.execute()
        guard querySuccess else {
            LogFile.info("查询错误sql:" + sql)
            LogFile.error(mysql.errorMessage())
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
                resultArr.append(resultDict)
            }
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
                    LogFile.error(error.localizedDescription)
                    assertionFailure("check you func columntype,func customColumnsType,property type")
                }
            }
            stmt.close()
            return modelArray
        } catch  {
            stmt.close()
            LogFile.error(error.localizedDescription)
            
        }
        return nil
    }
}
#endif
