//
//  UpdateTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class UpdateTest: XCTestCase {
    
    
    func testUpdate1() {
        let stmt1 = Update(Person.self).set("name = ?").where("name = ?").stmt
        let stmt2 = "update Person set name = ? where name = ? "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testUpdate2() {
        let stmt1 = Update(Person.self).set(["name"]).where("name = ?").stmt
        let stmt2 = "update Person set name=? where name = ? "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testUpdate3() {
        let stmt1 = Update(Person.self).set(["name","age"]).where("name = ?").stmt
        let stmt2 = "update Person set name=?,age=? where name = ? "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testUpdate4() {
        let stmt1 = Update(Person.self).set(["name","age"]).stmt
        let stmt2 = "update Person set name=?,age=? "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
}
