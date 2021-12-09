//
//  SFileBaseTableViewCell.swift
//  SwiftyFileBrowser
//
//  Created by b612 on 2021/12/9.
//

import UIKit
// 列表cell父类
open class SFileBaseTableViewCell: UITableViewCell {
    open var indexPath: IndexPath?
    open var file: SFile?
    open weak var delegate: SFileBrowserDelegate?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
