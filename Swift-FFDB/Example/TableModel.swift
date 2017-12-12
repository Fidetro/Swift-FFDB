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
    
    static func memoryPropertys() -> [String]? {
        return nil
    }
    
    static func customColumnsType() -> [String : String]? {
        return nil
    }
    
    static func customColumns() -> [String : String]? {
        return nil
    }
    
    var name : String?
    var creatTime : Date?
    var address = String()
    var  test: Float?
}

struct FFGood :FFObject {
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
    
    var goodName : String?
    var creatTime : Date?
    var price = Float()
}
