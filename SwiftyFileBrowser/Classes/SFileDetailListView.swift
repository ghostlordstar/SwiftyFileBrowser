//
//  SFileDetailListView.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/11/24.
//

import UIKit

class SFileDetailListView: UIView {
    
    private(set) var filesDataSource: [SFile] = [SFile]()
    weak var delegate: SFileBrowserDelegate?
    var longPressIndexPathDidChange: ((_ indexPath: IndexPath?)->())?
    var longPressMenuElements: [UIMenuElement]?
    
    //    lazy var longPressGesture: UILongPressGestureRecognizer = {
    //        let longPressGesture = UILongPressGestureRecognizer.init(target: self, action: #selector(p_longPressAction))
    //        return longPressGesture
    //    }()
    
    lazy var listView: UITableView = {
        var style = UITableView.Style.plain
        if #available(iOS 13.0, *) {
            style = UITableView.Style.insetGrouped
        } else {
            style = UITableView.Style.grouped
        }
        let listView = UITableView.init(frame: .zero, style: style)
        listView.delegate = self
        listView.dataSource = self
        listView.register(SFileDetailCell.self, forCellReuseIdentifier: SFileDetailCell.identifierOfCell())
        listView.backgroundColor = UIColor.white
        listView.showsVerticalScrollIndicator = false
        listView.showsHorizontalScrollIndicator = false
        listView.estimatedRowHeight = 0
        listView.estimatedSectionHeaderHeight = 0
        listView.estimatedSectionFooterHeight = 0
        listView.separatorStyle = .singleLine
        listView.separatorInset = .init(top: 0, left: 60.scale, bottom: 0, right: 0)
        //        listView.addGestureRecognizer(self.longPressGesture)
        return listView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.p_setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func p_setUpUI() {
        self.addSubview(self.listView)
        self.listView.translatesAutoresizingMaskIntoConstraints = false
        self.listView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.listView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.listView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.listView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    //    @objc func p_longPressAction(gesture: UILongPressGestureRecognizer?) {
    //        if let ges = gesture, ges.state == .began {
    //            let point = ges.location(in: self.listView)
    //            let indexPath = self.listView.indexPathForRow(at: point)
    //            if let index = indexPath {
    //                let file = self.filesDataSource[index.row]
    //                self.delegate?.fileLongTouchAction(indexPath: index, file: file)
    //            }
    //        }
    //    }
    
    func reloadList(files: [SFile]?) {
        if let files = files {
            DispatchQueue.main.async { [weak self] in
                self?.filesDataSource = files
                self?.listView.reloadData()
            }
        }
    }
    // MARK: update file state
    func updateFileState(file: SFile) {
        for (index, oldFile) in self.filesDataSource.enumerated() {
            if oldFile.identifier == file.identifier {
                oldFile.copyFromFile(file: file)
                self.updateListCell(index: index)
                return
            }
        }
    }
    
    func updateFileState(fileIdentifier: String, fileState: SFileState) {
        for (index, oldFile) in self.filesDataSource.enumerated() {
            if oldFile.identifier == fileIdentifier {
                oldFile.state = fileState
                self.updateListCell(index: index)
                return
            }
        }
    }
    
    func currentVisibleIndexPath() -> [IndexPath]? {
        return self.listView.indexPathsForVisibleRows;
    }
    
    func updateListCell(index: Int?) {
        if let idx = index, idx >= 0 && self.filesDataSource.count > idx {
            self.updateListCell(index: IndexPath.init(row: idx, section: 0))
        }
    }
    
    func updateListCell(index: IndexPath?) {
        if let idx = index, idx.row >= 0, self.filesDataSource.count > idx.row {
            self.listView.reloadRows(at: [idx], with: .none)
        }
    }
    
    func scrollToVisibleIndexPath(indexPath: IndexPath?, animated: Bool = false) {
        if let indexPath = indexPath {
            self.listView.scrollToRow(at: indexPath, at: .none, animated: animated)
        }
    }
}

extension SFileDetailListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let file = self.filesDataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SFileDetailCell.identifierOfCell(), for: indexPath)
        if let sfileCell = cell as? SFileBaseTableViewCell {
            sfileCell.delegate = self
        }
        if let sfileCell = cell as? SFileCellSetupProtocol {
            sfileCell.setupCell(indexPath: indexPath, file: file)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = self.filesDataSource[indexPath.row]
        self.fileTouchAction(indexPath: indexPath, file: file)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.scale
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { return nil }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0.001 }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { return nil }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0.001 }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let actions = self.longPressMenuElements else { return nil }
        self.longPressIndexPathDidChange?(indexPath)
        let menuView = UIMenu.init(title: "", image: nil, identifier: UIMenu.Identifier.init(rawValue: "com.swiftFileBrowser.longpress.menuView"), options: UIMenu.Options.displayInline, children: actions)
        return UIContextMenuConfiguration.init(identifier: nil, previewProvider: nil) { _ in
            menuView
        }
    }
    
    func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        self.longPressIndexPathDidChange?(nil)
    }
}

extension SFileDetailListView: SFileBrowserDelegate {
    func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileDownloadButtonAction(indexPath: indexPath, file: file)
    }
    
    func fileTouchAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileTouchAction(indexPath: indexPath, file: file)
    }
}
