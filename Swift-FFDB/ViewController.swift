//
//  ViewController.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var insert = Insert()
        
        insert.into(tableName: "aa")
        
        
//        person.primaryID = "bb"
//        print("\(person.propertyOfSelf())")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

