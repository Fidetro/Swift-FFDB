//
//  UpdateTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import XCTest

class UpdateTest: XCTestCase {
    
    
    func testUpdateTable() {
        TestStoreModel.registerTable()
        var object = TestStoreModel()
        object.name = "zzcaa"
        let sql1 = Update(TestStoreModel.self).sqlStatement!
        print(sql1)
        let sql2 = Update(TestStoreModel.self).set(["name"]).sqlStatement!
        print(sql2)
        let sql3 = Update(TestStoreModel.self).set("name = 'zxccs'").sqlStatement!
        print(sql3)
        do {
            let _ =  try Update(TestStoreModel.self).set(["name"]).execute()
            let _ =  try Update(TestStoreModel.self).set("name = 'zxccs'").execute()
        } catch  {
            
        }
    }
    
    func testUpdateUnfind() {
        var object = TestStoreModel()
        object.name = "zzcaa"
        let sql4 = Update(TestStoreModel.self).set(["unfind"]).sqlStatement!
        print(sql4)
    }
    
}
