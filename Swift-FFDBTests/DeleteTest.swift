//
//  DeleteTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/10/13.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class DeleteTest: XCTestCase {

    func testDeleteObject() {
        let model = TestStoreModel()
        print(Delete().from(model.subType).whereFormat("name > \'50\'").sqlStatement!)
    }
    

    
}
