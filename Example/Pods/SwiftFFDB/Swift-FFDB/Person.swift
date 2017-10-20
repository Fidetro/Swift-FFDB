//
//  Person.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/10/18.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

struct Person :FFObject {
    var primaryID: Int64?
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    
    var date :Date?
    
}
