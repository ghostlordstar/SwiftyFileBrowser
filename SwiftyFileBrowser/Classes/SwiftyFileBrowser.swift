//
//  SwiftyFileBrowser.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/11/24.
//

import UIKit
// list type
public enum SFileBrowserListType: Int {
    case list       // list
    case icons      // icon
    
    public func next() -> SFileBrowserListType {
        switch self {
        case .list:
            return .icons
        case .icons:
            return .list
        }
    }
}



public class SwiftyFileBrowser: UIView {
    public private(set) var listType: SFileBrowserListType = .list
    public private(set) var files: [SFile]?
    weak public var delegate: SFileBrowserDelegate?
    public var contentInsets: UIEdgeInsets? {
        didSet {
            if let insets = contentInsets {
                self.listView.listView.contentInset = insets
                self.iconsView.listView.contentInset = insets
            }else {
                self.listView.listView.contentInset = .zero
                self.iconsView.listView.contentInset = .zero
            }
        }
    }
    public var contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior? {
        didSet {
            if let behavior = contentInsetAdjustmentBehavior {
                self.listView.listView.contentInsetAdjustmentBehavior = behavior
                self.iconsView.listView.contentInsetAdjustmentBehavior = behavior
            }
        }
    }
    
    // current long press cell indexPath
    public private(set) var longPressIndex: IndexPath?
    
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
        self.listType = .list
        self.p_setUpUI()
    }
    
    public convenience init(frame: CGRect, type: SFileBrowserListType = .list) {
        self.init(frame: frame)
        self.listType = type
        self.p_setUpUI()
    }
    
    func p_setUpUI() {
        self.listView.frame = self.bounds
        self.iconsView.frame = self.bounds
        self.listView.delegate = self
        self.iconsView.delegate = self
        self.addSubview(self.listView)
        self.addSubview(self.iconsView)
        self.switchTo(listType: self.listType)
    }
    
    public func reloadBrowser(files: [SFile]?) {
        self.listView.reloadList(files: files)
        self.iconsView.reloadList(files: files)
    }
    
    public func updateFileState(file: SFile) {
        self.listView.updateFileState(file: file)
    }
    
    public func updateFileState(fileIdentifier: String, fileState: SFileState) {
        self.listView.updateFileState(fileIdentifier: fileIdentifier, fileState: fileState)
    }
    
    /// 循环切换到下一个样式
    /// - Parameter complete: 完成回调
    public func switchTo(complete:((_ listType: SFileBrowserListType)->())? = nil) {
        self.switchTo(listType: self.listType.next(), complete: complete)
    }
    
    /// 切换到指定样式
    /// - Parameter complete: 完成回调
    public func switchTo(listType: SFileBrowserListType, complete:((_ listType: SFileBrowserListType)->())? = nil) {
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
        complete?(listType)
    }
}

extension SwiftyFileBrowser: SFileBrowserDelegate {
    public func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileDownloadButtonAction(indexPath: indexPath, file: file)
    }
    
    public func fileTouchAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileTouchAction(indexPath: indexPath, file: file)
    }
    
    public func fileLongPressAction(indexPath: IndexPath?, file: SFile) -> UIContextMenuConfiguration? {
        self.longPressIndex = indexPath
        return self.delegate?.fileLongPressAction(indexPath: indexPath, file: file)
    }
    
    public func fileDidEndLongPressAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileDidEndLongPressAction(indexPath: indexPath, file: file)
        self.longPressIndex = nil
    }
}
