//
//  ProtocolTests.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 13/03/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest

class ProtocolTests: XCTestCase {
    
    func testProtocolModelInsert() {
        Person.registerTable()
        Person.insert(["name"], values: ["1"])
        Person.insert(["name"], values: ["2"])
        Person.insert(["name"], values: ["3"])
        Person.insert(["name"], values: ["4"])
        Person.insert(["name"], values: ["5"])
        Person.insert(["name"], values: ["6"])
        let person7 = Person()
        person7.name = "7"
        person7.insert()
    }
    
    func testProtocolSelectAll() {
        guard let modelList = Person.select() as? [Person]  else {
            XCTFail()
            return
        }
        for model in modelList {
            print(model.name ?? "null")
        }
    }
    
    func testProtocolUpdate() {
        Person.update(set: "name = ?", where: "name = ?", values: ["4","2"])
        testProtocolSelectAll()
    }
    
    func testProtocolDelete() {
        Person.delete(where: "name = ?", values: ["1"])
        testProtocolSelectAll()
    }
    
    func testDate()  {
        Person.registerTable()
        Person.insert(["birthday"], values: [Date()])
        guard let modelList = Person.select() as? [Person]  else {
            XCTFail()
            return
        }
        for model in modelList {
            print(model.birthday ?? "null")
        }
    }
    
}
