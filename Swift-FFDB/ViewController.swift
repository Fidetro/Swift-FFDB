//
//  ViewController.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

struct Man:FFObject {
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
    
    
}

 class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        FFDB.setup(.FMDB)
        
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

