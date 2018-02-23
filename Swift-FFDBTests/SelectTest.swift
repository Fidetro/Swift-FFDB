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
        let sql1 = Select().from(TestStoreModel.self).whereFormat("name != 'who'").order(by: "date > 0", .asc).sqlStatement!
        print(sql1)
        let sql2 = Select().from(TestStoreModel.self).whereFormat("name != ?").order(by: "date > 0", .asc).sqlStatement!
        print(sql2)
        do {
            try Select()
                .from(TestStoreModel.self)
                .whereFormat("name != 'who'")
                .order(by: "date > 0", .asc)
                .execute(TestStoreModel.self)
            
            
            try Select()
                .from(TestStoreModel.self)
                .whereFormat("name != ?")
                .order(by: "date > 0", .asc)
                .execute(database: nil, TestStoreModel.self, values: ["cccc"])
        } catch  {
            
        }
        
    }
    
}
