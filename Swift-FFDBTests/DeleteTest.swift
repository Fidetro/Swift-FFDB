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
       let sql1 = Delete().from(model.subType).whereFormat("name > \'50\'").sqlStatement
        print(sql1!)
       let sql2 = Delete().from(TestStoreModel.self).sqlStatement
        print(sql2!)
        do {
         let _ =  try  Delete().from(model.subType).whereFormat("name > ?").execute(database: nil, values: ["zxc"])
        } catch  {
            
        }
    }
    

    
}
