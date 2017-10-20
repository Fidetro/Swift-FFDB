//
//  Insert.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/27.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

public struct Insert {
    
    fileprivate var tableClass : FFObject.Type?
    
    var sqlStatement : String?
    
    
    init() {
        sqlStatement = ""
        tableClass = nil
    }
    
  public   func into(_ table:FFObject.Type) -> Insert {
        var insert = self
        insert.tableClass = table
        insert.sqlStatement?.append(" insert into " + table.tableName())
        
            return insert
        }
    
  public  func columns(_ columnsArray:[String]?) -> Insert {
        var insert = self
        var columnsString = String()
        if let columns = columnsArray {
            columnsString = columns.stringToColumns()
        }else{
            if let classColumns = insert.tableClass?.columnsOfSelf() {
                columnsString = classColumns.stringToColumns()
            }else{
                assertionFailure("tableClass is nil")
            }
        }
        insert.sqlStatement?.append(" (\(columnsString)) ")
        return insert
    }
    
  public  func columns(_ table:FFObject.Type) -> Insert {
        return self.columns(table.columnsOfSelf())
    }
    
 public   func values(_ valuesArray:[Any]) -> Insert {
        var insert = self
        var valuesString = " values "
        valuesString.append(" (\(valuesArray.stringToValues()));")
        insert.sqlStatement?.append(valuesString)
        return insert
    }
 public     func values(_ object:FFObject) -> Insert {
        var insert = self
        var valuesString = " values "
        valuesString.append(" (\(object.allValue().stringToValues()));")
        insert.sqlStatement?.append(valuesString)
        return insert
    }
    
  public  func execute() -> Bool {
        guard let connect = FFDB.connect else {
            assertionFailure("must be instance FFDB.setup(_ type:FFDBConnectType)")
            return false
        }
        guard let sql = sqlStatement else {
            assertionFailure("sql can't nil")
            return false
        }
        return connect.executeDBUpdateAfterClose(sql: sql)
    }
}

extension Array {
    fileprivate func stringToColumns() -> String {
        var columnsString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                columnsString.append(anyToString(element))
            }else{
                columnsString.append(","+anyToString(element))
            }
        }
        return columnsString
    }
    
    fileprivate func stringToValues() -> String {
        var valuesString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                valuesString.append("\'\(anyToString(element))\'")
            }else{
                valuesString.append(","+"\'\(anyToString(element))\'")
            }
        }
        return valuesString
    }
}

