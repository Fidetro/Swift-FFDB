//
//  DataTest.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 26/03/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest
extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
}
class DataTest: XCTestCase {
    
    func testData() {        
        
        DataModel.registerTable()
        let model = DataModel()
        model.insert()
        model.insert()
        model.insert()
        let data = ["test":"123"]
//        print(data)
//        print(data.base64EncodedString())
//        Data(bytes: 0x111)
        
//        DataModel.insert(["data","name"], values: [data,"你好"])
        do{
   
            guard let list = try FFDBManager.select(DataModel.self, order: nil) as? [DataModel] else {
            return
            }
  
//            print(list.last?.data)
        }catch{
            print(error)
        }
        
        
    }
    
}
