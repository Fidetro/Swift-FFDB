//
//  FFDBManager.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/9/12.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

struct FFDBManager {
    static func insert(_ object:FFObject!,_ columns:[String]?) {
        if let columnsArray = columns {
            var values = Array<Any>()
            for key in columnsArray {
                values.append(object.valueFrom(key))
            }
            print(Insert().into(object.subType).columns(columnsArray).values(values).sqlStatement!)
        }else{
            print(Insert().into(object.subType).columns(object.subType).values(object).sqlStatement!)
        }
    }
    static func insert(_ object:FFObject!) {
        print(Insert().into(object.subType).columns(object.subType).values(object).sqlStatement!)
    }
}

