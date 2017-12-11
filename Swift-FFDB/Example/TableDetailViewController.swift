//
//  TableDetailViewController.swift
//  devSwiftFFDB_Example
//
//  Created by Fidetro on 2017/10/18.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let onRightClick =  #selector(TableDetailViewController.onRightClick)
    
}

class TableDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var type : FFObject.Type?
    var dataSource : [FFObject]?
    var contentOffset : CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentSize = view.bounds.size
        
        let layout = CustomCollectionViewLayout(number: type!.columnsOfSelf().count+1)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib.init(nibName: "ContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: .onRightClick)
        refreshEvent()
    }
    
    func refreshEvent() {
        dataSource = type?.select(where: nil, values: nil)
        collectionView.reloadData()
    }
    @objc func onRightClick() {
        let a = type?.init()
        a?.insert()
        refreshEvent()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        guard let count = dataSource?.count else{
            return 1
        }
        return count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type!.columnsOfSelf().count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        
        if indexPath.section % 2 != 0 {
            cell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if indexPath.row == 0 {
            cell.contentLabel.text = indexPath.section == 0 ? "row":"\(indexPath.section)"
        }else if indexPath.section == 0 {
            if indexPath.row == 1 {
                cell.contentLabel.text = "primaryID"
            }else{
                cell.contentLabel.text = type!.columnsOfSelf()[indexPath.row - 2]
            }
        }else{
            let object = dataSource![indexPath.section - 1]
            if indexPath.row == 1 {
                cell.contentLabel.text = "\(object.primaryID!)"
            }else{
                let value = object.valueNotNullFrom(type!.columnsOfSelf()[indexPath.row - 2])
                cell.contentLabel.text = value
            }
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        guard indexPath.section != 0 else {
            return
        }
        
        switch indexPath.row {
        case 0:
            showDeleteAlert(delete: { [weak self] in
                let object = self?.dataSource![indexPath.section - 1]
                object?.delete()
                self?.refreshEvent()
            })
        case 2...type!.columnsOfSelf().count:
            let object = self.dataSource![indexPath.section - 1]
            showEditAlert(eidt: { [weak self] (textField) in
                let value = object.valueNotNullFrom((self?.type!.columnsOfSelf()[indexPath.row - 2])!)
                textField.text = value
                
            }, update: {[weak self] (text)  in
                let column = self?.type!.columnsOfSelf()[indexPath.row - 2]
                object.update(set:"\(String(describing: column)) = '\(text)'", values: nil)
                self?.refreshEvent()
            })
        default:
            break
        }
}
    
    func showEditAlert(eidt: @escaping (_ textField:UITextField)->(),update: @escaping (_ text:String)->()) {
        let textAlertVC = UIAlertController.init(title: "edit", message: nil, preferredStyle: .alert)
        textAlertVC.addTextField(configurationHandler: { (textField) in
            eidt(textField)
        })
        textAlertVC.addAction(UIAlertAction(title: "update", style: .default, handler: { (_) in
            if let text = textAlertVC.textFields?.last?.text {
                update(text)
            }
            
        }))
        textAlertVC.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(textAlertVC, animated: true, completion: nil)
    }
    
    func showDeleteAlert(delete: @escaping ()->()) {
        
        let alertVC = UIAlertController.init(title: "deleteRow", message: nil, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "delete", style: .default, handler: { (_) in
            delete()
        }))
        alertVC.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
