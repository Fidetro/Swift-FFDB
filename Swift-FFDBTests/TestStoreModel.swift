//
//  TestStoreModel.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 2017/9/23.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

struct TestStoreModel:FFObject {
    static func primaryKeyColumn() -> String? {
        return "primaryID"
    }
    
    
    
    var primaryID: Int64?
    var date : Int?
    var name : String?
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    static func autoincrementColumn() -> String? {
        return "primaryID"
    }
}


