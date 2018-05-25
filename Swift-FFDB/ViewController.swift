//
//  ViewController.swift
//  Swift-FFDB
//
//  Created by Fidetro on 2017/8/20.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit




 class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
//        FFDB.setup(.FMDB)
        
        Select("").from("").orderBy("")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

