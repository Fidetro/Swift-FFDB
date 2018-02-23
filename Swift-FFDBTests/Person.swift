//
//  Person.swift
//  Swift-FFDBTests
//
//  Created by Fidetro on 13/02/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//



class Person: FFObject {

    var primaryID: Int64?
    var name : String?
    
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
}
