//
//  InsertTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/11.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class InsertTest: XCTestCase {
    
    func testInsertPerson() {
        let insert = Insert().into(Person.self).columns(["sd","zx"]).values(["asd","zxccc"])
        if let sql = insert.sqlStatement {
            print(sql)
        }
        let insertClass = Insert().into(Person.self).columns(Person.self)
        if let sql = insertClass.sqlStatement {
            print(sql)
        }
    }
    
    
    
    
    
    

}
