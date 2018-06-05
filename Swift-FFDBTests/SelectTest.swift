//
//  SelectTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/10/13.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class SelectTest: XCTestCase {
    
    func testSelect1() {
        let stmt1 = Select("*").from(Person.self).stmt
        let stmt2 = "select * from Person "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testSelect2() {
        let stmt1 = Select("*").from(Person.self).where("name = ?").stmt
        let stmt2 = "select * from Person where name = ? "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testSelect3() {
        let stmt1 = Select("*").from(Person.self).where("name = ?").limit("1").stmt
        let stmt2 = "select * from Person where name = ? limit 1 "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testSelect4() {
        let stmt1 = Select("*").from(Person.self).where("name = ?").limit("1").offset("0").stmt
        let stmt2 = "select * from Person where name = ? limit 1 offset 0 "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
}
