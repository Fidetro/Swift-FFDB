//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


extension FIDRuntime {
    func propertyOfSelf() -> Array<String> {
        let mirror  = Mirror(reflecting: self);
        var propertys = Array<String>();
        for case let (label?, _) in mirror.children {
            propertys.append(label)
        }
        return propertys;
    }
    func className() -> String {
        let mirror  = Mirror(reflecting: self);
        return String(describing: mirror.subjectType);
    }
}

extension FFDataBaseModel {
    
}
