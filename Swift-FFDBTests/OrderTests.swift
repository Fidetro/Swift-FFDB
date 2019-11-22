//
//  OrderTests.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2019/11/23.
//  Copyright © 2019 Fidetro. All rights reserved.
//

import XCTest

class OrderTests: XCTestCase {

    func testOrder() {
        Person.registerTable()
        Person.delete()
        let person = Person()
        person.name = "zhang"
        person.number = 2
        person.insert()
        
        person.number = 4
        person.insert()
        
        person.number = 3
        person.insert()
        
        test1()
        test2()
    }
    
    func test1() {
        guard let list = Person.select(where: "name = 'zhang'", orderBy: "number", orderByType: .desc) as? [Person] else {
            XCTFail()
            return
        }
        orderTest(list: list)
    }
    
    func test2() {
        
        do{
            guard let list = try FFDBManager.select(Person.self, nil, where: nil, values: nil, order: [("number",OrderByType.desc),("primaryID",OrderByType.asc)], database: nil) as? [Person] else {
                XCTFail()
                return
            }
            
            orderTest(list: list)
        }catch{
            print(error)
        }
        
    }
    
    
    func orderTest(list:[Person]) {
        var last : Person?
        for p in list {
            if let last = last {
                if last.number! < p.number! {
                    XCTFail()
                }
            }
            last = p
        }

    }

}
