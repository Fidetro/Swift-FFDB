//
//  Insert.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/27.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

struct Insert {
    
    fileprivate var tableClass : FFObject.Type?
    
    var sqlStatement : String?
    
    
    init() {
        sqlStatement = ""
        tableClass = nil
    }
    
     func into(_ table:FFObject.Type) -> Insert {
        var insert = self
        insert.tableClass = table
        insert.sqlStatement?.append(" insert into " + table.tableName())
        
            return insert
        }
    
    func columns(_ columnsArray:[String]?) -> Insert {
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
    
    func columns(_ table:FFObject.Type) -> Insert {
        return self.columns(table.columnsOfSelf())
    }
    
    func values(_ valuesArray:[Any]) -> Insert {
        var insert = self
        var valuesString = " values "
        valuesString.append(" (\(valuesArray.stringToValues()));")
        insert.sqlStatement?.append(valuesString)
        return insert
    }
      func values(_ object:FFObject) -> Insert {
        var insert = self
        var valuesString = " values "
        valuesString.append(" (\(object.allValue().stringToValues()));")
        insert.sqlStatement?.append(valuesString)
        return insert
    }
}

extension Array {
    fileprivate func stringToColumns() -> String {
        var columnsString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                columnsString.append(String(describing: element))
            }else{
                columnsString.append(","+String(describing: element))
            }
        }
        return columnsString
    }
    
    fileprivate func stringToValues() -> String {
        var valuesString = String()
        for (index,element) in self.enumerated() {
            if index == 0 {
                valuesString.append("\'\(String(describing: element))\'")
            }else{
                valuesString.append(","+"\'\(String(describing: element))\'")
            }
        }
        return valuesString
    }
}

