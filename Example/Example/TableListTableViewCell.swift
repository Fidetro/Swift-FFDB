//
//  TableListTableViewCell.swift
//  Example
//
//  Created by Fidetro on 2017/10/18.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit
import SwiftFFDB
class TableListTableViewCell: UITableViewCell {
    
    static func dequeueReusableWithTableView(tableView:UITableView,style: UITableViewCellStyle) -> TableListTableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: TableListTableViewCell.identifier())
        if let listCell = cell {
            return listCell as! TableListTableViewCell
        }else{
           let listCell = TableListTableViewCell.init(style: style, reuseIdentifier: TableListTableViewCell.identifier())
            return listCell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func identifier() -> String {
        return "TableListTableViewCell"
    }
    
    func updateDataSource(table:FFObject.Type) {
        textLabel!.text = table.tableName()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
