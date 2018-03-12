//
//  FFDBManagerTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest
class ManagerTestModel: NSObject,Decodable {
    let name : String?
    override init() {
        self.name = ""
        super.init()
    }
}
class FFDBManagerTest: XCTestCase {
    
 
    
    func testInsert()  {
        Person.registerTable()
        let person1 = Person.init()
        person1.name = "1"
        let person4 = Person.init()
        person4.name = "4"
        do{
            try FFDBManager.insert(person1)
            try FFDBManager.insert(person4)
            try FFDBManager.insert(Person.self, ["name"], values: ["2"])
            try FFDBManager.insert(Person.self, ["name"], values: ["2"])
            try FFDBManager.insert(Person.self, ["name"], values: ["3"])
        }catch{
            print(error)
            XCTFail()
        }
    }
    
    func testSelect() {
        Person.registerTable()
        do{
            let totalCount = try FFDBManager.select(Person.self)?.count
            XCTAssertTrue(5 == totalCount)
            let count2 = try FFDBManager.select(Person.self, nil, where: "name = ?", values: ["2"])?.count
            XCTAssertTrue(2 == count2)
            let count4 = try FFDBManager.select(Person.self, nil, where: "name = ?", values: ["4"])?.count
            XCTAssertTrue(1 == count4)
            guard let model = try FFDBManager.select(Person.self, ["name"], where: "name = 3",return:ManagerTestModel.self)?.first as! ManagerTestModel? else {
                XCTFail()
                return
            }
            XCTAssertTrue(model.name == "3")
            
        }catch{
            print(error)
            XCTFail()
        }
    }
    
    func testUpdate() {
        
        
    }
    
    func testDelete() {
        
    }
    
}
