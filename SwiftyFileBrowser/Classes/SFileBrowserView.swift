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
    
    func next() -> SFileBrowserListType {
        switch self {
        case .list:
            return .icons
        case .icons:
            return .list
        }
    }
}

public class SFileBrowserView: UIView {
    private(set) var listType: SFileBrowserListType = .list
    private(set) var files: [SFile]?
    
    var listView: SFileDetailListView = {
        let listView = SFileDetailListView()
        listView.isHidden = false
        return listView
    }()
    
    var iconsView: SFileIconsListView = {
        let iconsView = SFileIconsListView()
        iconsView.isHidden = true
        return iconsView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect, type: SFileBrowserListType = .list) {
        self.init(frame: frame)
        self.listType = type
        self.p_setUpUI()
    }

    func p_setUpUI() {
        self.listView.frame = self.bounds
        self.iconsView.frame = self.bounds
        self.addSubview(self.listView)
        self.addSubview(self.iconsView)
    }
    
    public func reloadBrowser(files: [SFile]?) {
        self.listView.reloadList(files: files)
        self.iconsView.reloadList(files: files)
    }
    
    public func switchTo() {
        self.switchTo(listType: self.listType.next())
    }
    
    public func switchTo(listType: SFileBrowserListType) {
        guard listType != self.listType else { return }
        self.listType = listType
        switch listType {
        case .list:
            DispatchQueue.main.async {
                self.iconsView.isHidden = true
                self.listView.isHidden = false
                self.listView.scrollToVisibleIndexPath(indexPath: self.iconsView.currentVisibleIndexPath()?.first)
            }
        
        case .icons:
            DispatchQueue.main.async {
            self.listView.isHidden = true
            self.iconsView.isHidden = false
            self.iconsView.scrollToVisibleIndexPath(indexPath: self.listView.currentVisibleIndexPath()?.first)
            }
        }
    }
}
