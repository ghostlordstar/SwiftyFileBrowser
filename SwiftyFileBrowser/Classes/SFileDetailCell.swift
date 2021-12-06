//
//  SFileDetailCell.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/11/24.
//

import UIKit

class SFileDetailCell: UITableViewCell {
    var indexPath: IndexPath?
    var file: SFile?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.p_setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func p_setUpUI() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.detailLabel)
        self.contentView.addSubview(self.thumbnailImageView)
        self.contentView.addSubview(self.appIconView)
//        self.contentView.addSubview(self.downloadBtn)
        
        p_layout()
    }
    
    func p_layout() {
        
        self.thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        self.thumbnailImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.scale).isActive = true
        self.thumbnailImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.thumbnailImageView.widthAnchor.constraint(equalToConstant: 50.scale).isActive = true
        self.thumbnailImageView.heightAnchor.constraint(equalToConstant: 50.scale).isActive = true
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.leftAnchor.constraint(equalTo: self.thumbnailImageView.rightAnchor, constant: 5.scale).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0.scale).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -30.scale).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 20.scale).isActive = true
        
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.detailLabel.leftAnchor.constraint(equalTo: self.thumbnailImageView.rightAnchor, constant: 5.scale).isActive = true
        self.detailLabel.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 5.scale).isActive = true
        self.detailLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -30.scale).isActive = true
        self.detailLabel.heightAnchor.constraint(equalToConstant: 16.scale).isActive = true
    }
    
    // MARK: - lazy load -
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.lineBreakMode = .byTruncatingMiddle
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel.init()
        detailLabel.lineBreakMode = .byTruncatingMiddle
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.textColor = .darkGray
        detailLabel.backgroundColor = .clear
        return detailLabel
    }()
    
    lazy var thumbnailImageView: UIImageView = {
        let thumbnailImageView = UIImageView.init()
        return thumbnailImageView
    }()
    
    lazy var appIconView: UIImageView = {
        let appIconView = UIImageView.init()
        return appIconView
    }()
    
//    lazy var downloadBtn: UIButton = {
//        let downloadBtn = UIButton.init()
//        downloadBtn.buttonType =
//        downloadBtn.isHidden = true
//        return downloadBtn
//    }()
}

extension SFileDetailCell: SFileCellProtocol {
    func setupCell(indexPath: IndexPath?, file: SFile) {
        self.indexPath = indexPath
        self.file = file
        
        self.titleLabel.text = self.file?.fileName
        self.detailLabel.text = self.file?.detailText
        
        switch (self.file?.fileType ?? .unknow) {
        case .folder:
            self.thumbnailImageView.image = self.file?.thumbnail ?? UIImage.imageNamed("icon_folder_close", bundleForClass: SFileDetailCell.self)
            self.appIconView.image = self.file?.appIcon
            self.accessoryType = .disclosureIndicator
        default:
            self.thumbnailImageView.image = self.file?.thumbnail ?? UIImage.imageNamed("icon_file_unknow", bundleForClass: SFileDetailCell.self)
            self.appIconView.image = self.file?.appIcon
            self.accessoryType = .none
        }
    }
    
    class func identifierOfCell() -> String {
        return "SFileDetailCell"
    }
}
