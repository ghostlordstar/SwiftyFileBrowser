//
//  SFileBrowserView.swift
//  SwiftyFileBrowser
//
//  Created by b612 on 2021/11/24.
//

import UIKit
// list type
public enum SFileBrowserListType: Int {
    case list       // list
    case icons      // icon
}

public class SFileBrowserView: UIView {
    private(set) var listType: SFileBrowserListType = .list
    private(set) var files: [SFile]?
    var listView: SFileDetailListView = {
        let listView = SFileDetailListView.init()
        listView.isHidden = false
        return listView
    }()
    
    var iconsView: SFileIconsListView = {
        let iconsView = SFileIconsListView.init()
        iconsView.isHidden = true
        return iconsView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, type: SFileBrowserListType = .list) {
        self.init(frame: frame)
        self.listType = type
        self.p_setUpUI()
    }

    func p_setUpUI() {
        self.addSubview(self.listView)
        self.addSubview(self.iconsView)
    }
    
    public func reloadBrowser(files: [SFile]?) {
        
    }
    
    public func switchTo(listType: SFileBrowserListType) {
        guard listType != self.listType else { return }
        self.listType = listType
        switch listType {
        case .list:
            self.iconsView.isHidden = true
            self.listView.isHidden = false
        case .icons:
            self.listView.isHidden = true
            self.iconsView.isHidden = false
        }
    }
}
