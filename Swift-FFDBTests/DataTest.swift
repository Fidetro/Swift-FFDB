//
//  DataTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 26/03/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest

class DataTest: XCTestCase {
    
    func testData() {
        
        
        DataModel.registerTable()
        let model = DataModel()
        model.data = "aassd".data(using: .utf8)
        model.insert()
        
        guard let dbmodel = DataModel.select()?.first as? DataModel else { return }
        let str = String.init(data: dbmodel.data!, encoding: .utf8)
        print(str)
        

        
        
    }
    
}
