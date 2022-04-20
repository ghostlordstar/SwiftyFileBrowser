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
    weak var scrollDelegate: SFileBrowserScrollDelegate?
    var longPressIndex: IndexPath?
    
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
        let file = self.filesDataSource[indexPath.row]
        return self.delegate?.fileLongPressAction(indexPath: indexPath, file: file)
    }
    
    func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        if self.longPressIndex != nil, self.longPressIndex!.item < self.filesDataSource.count {
            let file = self.filesDataSource[self.longPressIndex!.row]
            self.delegate?.fileDidEndLongPressAction(indexPath: self.longPressIndex, file: file)
        }
    }
}

extension SFileDetailListView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewDidScroll?(scrollView)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewDidZoom?(scrollView)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.scrollDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        self.scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scrollDelegate?.viewForZooming?(in: scrollView)
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        self.scrollDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        self.scrollDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return self.scrollDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewDidScrollToTop?(scrollView)
    }

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        self.scrollDelegate?.scrollViewDidChangeAdjustedContentInset?(scrollView)
    }
}

extension SFileDetailListView: SFileBrowserDelegate {
    func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileDownloadButtonAction(indexPath: indexPath, file: file)
    }
    
    func fileTouchAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileTouchAction(indexPath: indexPath, file: file)
    }
    
    func fileLongPressAction(indexPath: IndexPath?, file: SFile) -> UIContextMenuConfiguration? {
        return self.delegate?.fileLongPressAction(indexPath: indexPath, file: file)
    }
    
    func fileDidEndLongPressAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileDidEndLongPressAction(indexPath: indexPath, file: file)
    }
}
