//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit


protocol FIDRuntime {
    func propertyOfSelf() -> Array<String>;
}

extension FIDRuntime {
    func propertyOfSelf() -> Array<String> {
        let aMirror  = Mirror(reflecting: self);
        var propertys = Array<String>()
        for case let (label?, value) in aMirror.children {
            print (label, value)
            propertys.append(label)
        }
        return propertys
    }
    static func pro() {
    let aMirror  = Mirror(reflecting: self);
    var propertys = Array<String>()
    for case let (label?, value) in aMirror.children {
    print (label, value)
    propertys.append(label)
    }
    }
}

protocol  FFDataBaseModel {
    //    var name : String?
    //    var age : Int?
    //    var ta : String?
    var primaryID : String { get set }
    func test()
    //    func test() {
    //        var db = FFDataBaseModel.init();
    //        db.name = "sb";
    //        let aMirror  = Mirror(reflecting: db);
    //
    //        for case let (label?, value) in aMirror.children {
    //            print (label, value)
    //        }
    
    //    }
}

extension FFDataBaseModel {
     
    func test() {
        let aMirror  = Mirror(reflecting: self);
        
        for case let (label?, value) in aMirror.children {
            print (label, value)
        }
    }
}
class FFDB: NSObject {
    
}



