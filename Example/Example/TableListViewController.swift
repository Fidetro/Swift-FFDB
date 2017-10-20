//
//  TableListViewController.swift
//  Example
//
//  Created by Fidetro on 2017/10/18.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit
import SwiftFFDB
class TableListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataSource = [FFObject.Type]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FFDB.setup(.FMDB)
        registerTable()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerTable() {
        dataSource.append(FFShop.self)
        dataSource.append(FFGood.self)
        FFShop.registerTable()
        FFGood.registerTable()
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableListTableViewCell.dequeueReusableWithTableView(tableView: tableView, style: .subtitle)
        let objectType = dataSource[indexPath.row]
        cell.updateDataSource(table: objectType)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableDetailViewController") as! TableDetailViewController
             let objectType = dataSource[indexPath.row]
        detailVC.type = objectType
        navigationController?.pushViewController(detailVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
