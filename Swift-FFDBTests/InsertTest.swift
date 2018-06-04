//
//  InsertTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/11.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class InsertTest: XCTestCase {
    
    func testInsert1() {
        let stmt1 = Insert().into(Person.self).columns(["name","number"]).values(2).stmt
        let stmt2 = "insert into Person (name,number) values (?,?) "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
   
    func testInsert2() {
        let stmt1 = Insert().into("Person").columns(["name","number"]).values(2).stmt
        let stmt2 = "insert into Person (name,number) values (?,?) "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testInsert3() {
        let stmt1 = Insert().into("Person").columns(["name","number"]).values("(?,?)").stmt
        let stmt2 = "insert into Person (name,number) values (?,?) "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testInsert4() {
        let stmt1 = Insert().into("Person").columns("(name,number)").values(2).stmt
        let stmt2 = "insert into Person (name,number) values (?,?) "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
    
    func testInsert5() {
        let stmt1 = Insert().into("Person").columns("(name,number)").values("(?,?)").stmt
        let stmt2 = "insert into Person (name,number) values (?,?) "
        if stmt1 != stmt2  {
            print(stmt1)
            print(stmt2)
            assertionFailure()
        }
    }
}
