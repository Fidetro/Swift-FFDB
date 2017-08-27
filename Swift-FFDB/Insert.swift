//
//  Insert.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/27.
//  Copyright © 2017年 Fidetro. All rights reserved.
//


struct Insert {
    
    var tableName:String! = "Zhang"
//    init(tableName:String) {
//
//        self.tableName = tableName
//    }
    
  public  mutating func into(tableName:String) -> Insert {
            self.tableName = tableName
            return self
        }
}

