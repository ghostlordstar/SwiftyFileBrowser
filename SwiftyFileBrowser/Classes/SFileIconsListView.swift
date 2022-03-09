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
}

extension SFileIconsListView: SFileBrowserDelegate {
    func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileDownloadButtonAction(indexPath: indexPath, file: file)
    }
    
    func fileLongTouchAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileLongTouchAction(indexPath: indexPath, file: file)
    }
    
    func fileTouchAction(indexPath: IndexPath?, file: SFile) {
        self.delegate?.fileTouchAction(indexPath: indexPath, file: file)
    }
}
