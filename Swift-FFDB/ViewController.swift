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
        FFDB.setup(.FMDB)
        Person.registerTable()
        print(Person.select(nil))
//        let person = Person.init(primaryID: 123, name: "asd", date: 123)
//        print(FFDB.connect)
//        print(FFDB.setup(.FMDB).connect)
//        print(FFDB.connect)
  
    }

    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

