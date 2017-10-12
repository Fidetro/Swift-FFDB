//
//  Person.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//



struct Person :FFObject {

    

    var primaryID: String?

    var name : String?
    
    mutating func setName( newName:String )-> Person {
        name = newName
        return self
    }
}
