//
//  DeleteTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/10/13.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class DeleteTest: XCTestCase {

    func testDelete1() {
        let stmt1 = Delete().from(Person.self).stmt
        let stmt2 = "delete from Person "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testDelete2() {
        let stmt1 = Delete().from(Person.self).where("name = zhang").stmt
        let stmt2 = "delete from Person where name = zhang "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testDelete3() {
        let stmt1 = Delete().from("Person").where("name = zhang").stmt        
        let stmt2 = "delete from Person where name = zhang "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
}
