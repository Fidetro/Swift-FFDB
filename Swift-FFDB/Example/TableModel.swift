//
//  TableModel.swift
//  devSwiftFFDB_Example
//
//  Created by Fidetro on 2017/10/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//
import UIKit



struct FFShop :FFObject {
    
    var primaryID: Int64?
    var name : String?
    var creatTime : Date?
    var address = String()
    var  test: Float?
    
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

struct FFGood :FFObject {
    var primaryID: Int64?
    var goodName : String?
    var creatTime : Date?
    var price = Float()
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func autoincrementColumn() -> String? {
        return "primaryID"
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    
}
