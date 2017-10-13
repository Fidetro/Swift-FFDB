//
//  UpdateTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class UpdateTest: XCTestCase {
    
 
    func testUpdateObject() {
        let object = TestStoreModel()
        
        print("\(Update(object).set().whereFormat("ss = 'a'").sqlStatement!)")
        print("\(Update(object).set(["date","name"]).whereFormat("ss = 'a'").sqlStatement!)")
        print("\(Update(object).set("date = ''").whereFormat("ss = 'a'").sqlStatement!)")
    }
 

}
