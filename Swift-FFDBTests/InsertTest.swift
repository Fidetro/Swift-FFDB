//
//  InsertTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/11.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class InsertTest: XCTestCase {
    
    func testInsertTestStore() {
        
        let sql1 = Insert().into(TestStoreModel.self).sqlStatement!
        print(sql1)
        let sql2 = Insert().into(TestStoreModel.self).columns(TestStoreModel.self).sqlStatement!
        print(sql2)
        let sql3 = Insert().into(TestStoreModel.self).columns(["unfind"]).sqlStatement!
        print(sql3)
        let sql4 = Insert().into(TestStoreModel.self).columns(["name"]).sqlStatement!
        print(sql4)
        let sql5 = Insert().into(TestStoreModel.self).columns(["name"]).values(["zccx"]).sqlStatement!
        print(sql5)
        let sql6 = Insert().into(TestStoreModel.self).columns(["name"]).values([1234]).sqlStatement!
        print(sql6)
        do {
            let _ = try Insert().into(TestStoreModel.self).columns(["name"]).values(["zccx"]).execute()
            
            let _ = try Insert().into(TestStoreModel.self).columns(["name"]).values([1234]).execute()
        } catch  {
            
        }
    }
    
    
    
    
    
    
    
}
