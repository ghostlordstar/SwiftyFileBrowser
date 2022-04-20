//
//  SFileIconsListView.swift
//  SwiftyFileBrowser
//
//  Created by walker on 2021/11/24.
//

import UIKit

class SFileIconsListView: UIView {
    
    private(set) var filesDataSource: [SFile] = [SFile]()
    weak var delegate: SFileBrowserDelegate?
    weak var scrollDelegate: SFileBrowserScrollDelegate?
    var longPressIndex: IndexPath?
    
    lazy var listView: UICollectionView = {
        let listView = UICollectionView.init(frame: .zero, collectionViewLayout: self.cvLayout)
        listView.delegate = self
        listView.dataSource = self
        listView.register(SFileIconsCell.self, forCellWithReuseIdentifier: SFileIconsCell.className)
        listView.backgroundColor = UIColor.white
        listView.showsVerticalScrollIndicator = false
        listView.showsHorizontalScrollIndicator = false
        return listView
    }()
    
    lazy var cvLayout: UICollectionViewFlowLayout = {
        let cvlayout = UICollectionViewFlowLayout.init()
        cvlayout.itemSize = CGSize(width: 100.scale, height: 170.scale)
        cvlayout.minimumInteritemSpacing = 5.scale
        cvlayout.sectionInset = UIEdgeInsets.init(top: 10.scale, left: 16.scale, bottom: 0, right: 16.scale)
        return cvlayout
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
    
    func currentVisibleIndexPath() -> [IndexPath]? {
        return self.listView.indexPathsForVisibleItems;
    }
    
    func scrollToVisibleIndexPath(indexPath: IndexPath?, animated: Bool = false) {
        if let indexPath = indexPath {
            self.listView.scrollToItem(at: indexPath, at: [], animated: animated)
        }
    }
    
}

extension SFileIconsListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filesDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let file = self.filesDataSource[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SFileIconsCell.className, for: indexPath)
        if let sfileCell = cell as? SFileBaseCollectionViewCell {
            sfileCell.delegate = self
        }
        if let sfileCell = cell as? SFileCellSetupProtocol {
            sfileCell.setupCell(indexPath: indexPath, file: file)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let file = self.filesDataSource[indexPath.item]
        self.fileTouchAction(indexPath: indexPath, file: file)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        self.longPressIndex = indexPath
        let file = self.filesDataSource[indexPath.row]
        return self.delegate?.fileLongPressAction(indexPath: indexPath, file: file)
    }
    
    func collectionView(_ collectionView: UICollectionView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
        if self.longPressIndex != nil, self.longPressIndex!.item < self.filesDataSource.count {
            let file = self.filesDataSource[self.longPressIndex!.row]
            self.delegate?.fileDidEndLongPressAction(indexPath: self.longPressIndex, file: file)
        }
    }
}

extension SFileIconsListView: SFileBrowserDelegate {
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

extension SFileIconsListView: UIScrollViewDelegate {
    
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
