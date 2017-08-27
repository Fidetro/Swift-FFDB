//
//  FFDB.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

//import UIKit


protocol FIDRuntime {
     func propertyOfSelf() -> Array<String>;
     func className() -> String;
}


protocol FFDataBaseModel:FIDRuntime {
    
    var primaryID : String { get set }
    
}






