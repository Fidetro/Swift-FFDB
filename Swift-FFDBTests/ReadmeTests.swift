//
//  ReadmeTests.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 13/02/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest
import Foundation
class ReadmeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
    }
    
    func testReadme() {
        let person = Person()
        person.name = "fidetro"
        person.insert()
        // find all Object
        guard   let _ = Person.select(where: nil) as! [Person]? else {
            // no object in database
            return
        }
        
        // find name is 'fidetro'
        guard   let _ = Person.select(where: "name = 'fidetro'") as! [Person]? else {
            // no object in database
            return
        }
        guard   let personList = Person.select(where: "name = 'fidetro'") as! [Person]? else {
            // no object in database
            return
        }
   
        for  p1 in personList {
            // delete this person in database
            p1.delete()
        }
        do{
        try FFDBManager.delete(Person.self, where: "name = 'fidetro'")
        }catch{
            print(error)
        }
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
