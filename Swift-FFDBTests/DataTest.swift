//
//  DataTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 26/03/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest

class DataTest: XCTestCase {
    
    func testData1() {
        DataModel.registerTable()
        DataModel.delete()
        let model = DataModel()
        model.data = "test".data(using: .utf8)
        model.insert()
        
        guard let dbmodel = DataModel.select()?.first as? DataModel else { return }
        let str = String(data: dbmodel.data!, encoding: .utf8)
        if str != "test" {
             XCTFail()
        }
    }
    
    
    func testData2() {
        DataModel.registerTable()
        DataModel.delete()
        DataModel.insert(["data"], values: ["test".data(using: .utf8)as Any])
        
        guard let dbmodel = DataModel.select()?.first as? DataModel else { return }
        let str = String(data: dbmodel.data!, encoding: .utf8)
        if str != "test" {
            XCTFail()
        }
    }
    
    func testData3() {
        DataModel.registerTable()
        DataModel.delete()
        do{
            try FFDBManager.insert(DataModel.self, ["data"], values: ["test".data(using: .utf8)as Any])
        }catch{
            guard let dbmodel = DataModel.select()?.first as? DataModel else { return }
            let str = String(data: dbmodel.data!, encoding: .utf8)
            if str != "test" {
                XCTFail()
            }
        }
    }
    
}
