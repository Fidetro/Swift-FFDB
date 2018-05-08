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

    
    func testManager() {
        insert()
        select()
        update()
        delete()
    }
    
    func insert()  {
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
    
    func select() {
        Person.registerTable()
        do{
            let totalCount = try FFDBManager.select(Person.self)?.count
            XCTAssertTrue(5 == totalCount)
            let count2 = try FFDBManager.select(Person.self, nil, where: "name = ?", values: ["2"])?.count
            XCTAssertTrue(2 == count2)
            let count4 = try FFDBManager.select(Person.self, nil, where: "name = ?", values: ["4"])?.count
            XCTAssertTrue(1 == count4)
            
//            let a = FFDBManager.select(Person.self, ["name"], where: "name = 3",return:ManagerTestModel.self)
            
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
    
    func update() {
        Person.registerTable()
        do{
        try FFDBManager.update(Person.self, set: "name = ?", where: "name == ?",values:["6","2"])
            guard let list = try FFDBManager.select(Person.self) as? [Person] else {
                XCTFail()
                return
            }
            for model in list {
                if model.name == "2" {
                    XCTFail()
                }
            }
        }catch{
            print(error)
            XCTFail()
        }
    }
    
    func delete() {
        Person.registerTable()
        do{
            guard let modelList = try FFDBManager.select(Person.self) as? [Person] else {
                XCTFail()
                return
            }
            print(modelList)
            
            try FFDBManager.delete(Person.self, where: "name = ?", values: ["6"])
            guard let list = try FFDBManager.select(Person.self) as? [Person] else {
                XCTFail()
                return
            }
            for model in list {
                if model.name == "6" {
                    XCTFail()
                }
            }
        }catch{
            print(error)
            XCTFail()
        }
    }
    
}
