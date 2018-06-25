//
//  DataModel.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 26/03/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import UIKit



class DataModel: FFObject {

    
    
    var primaryID: Int64?
    
    var name : String?
    var test : String?

    required init() {
        
    }
    
    static func primaryKeyColumn() -> String {
        return "primaryID"
    }
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    

    
    
}
