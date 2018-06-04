//
//  Person.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 13/02/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import Foundation

class Person: FFObject {
    static func primaryKeyColumn() -> String? {
        return "primaryID"
    }
    
    
    

    var primaryID: Int64?
    var name : String?
    var birthday : Date?
    
    required init() {
        
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
    
    static func autoincrementColumn() -> String? {
        return "primaryID"
    }
}
