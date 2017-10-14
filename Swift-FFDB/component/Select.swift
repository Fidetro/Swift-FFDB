//
//  Select.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/25.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

struct Select {
    fileprivate var tableClass : FFObject.Type?
    var sqlStatement : String?
    init() {
        sqlStatement = ""
        sqlStatement?.append(" select " + " * ")
    }
    init(_ columns:[String]) {
        sqlStatement = ""
        sqlStatement?.append(" select " + columns.stringToColumns())
    }
    func from(_ table:FFObject.Type) -> Select {
        var select = self
        select.tableClass = table
        select.sqlStatement?.append(" from " + table.tableName())
        return select
    }
    func whereFormat(_ condition:String) -> Select {
        var select = self
        select.sqlStatement?.append(" where " + condition + " ")
        return select
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
                valuesString.append(String(describing: element))
            }else{
                valuesString.append(","+String(describing: element))
            }
        }
        return valuesString
    }
}
