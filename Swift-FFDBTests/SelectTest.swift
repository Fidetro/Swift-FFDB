//
//  SelectTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/10/13.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class SelectTest: XCTestCase {
    
    func testSelect() {
        
        print(Select().from(TestStoreModel.self).whereFormat("name = 'fidetro'").sqlStatement!)
        print(Select(["name"]).from(TestStoreModel.self).sqlStatement!)
        print(Select(["name","age"]).from(TestStoreModel.self).whereFormat("test = ''").sqlStatement!)
        
    }
    
}
