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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, type: SFileBrowserListType = .list) {
        self.init(frame: frame)
        self.listType = type
    }

    public func reloadBrowser(files: [SFile]?) {
        
    }
    
    public func switchTo(listType: SFileBrowserListType) {
        guard listType != self.listType else { return }
        self.listType = listType
        switch listType {
        case .list:
        case .icons:
        }
    }
}
