//
//  SFileDetailListView.swift
//  SwiftyFileBrowser
//
//  Created by b612 on 2021/11/24.
//

import UIKit

class SFileDetailListView: UIView {

    private(set) var filesDataSource: [SFile] = [SFile]()
    
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
        listView.register(SFileDetailCell.self, forCellReuseIdentifier: "SFileDetailCell")
        listView.backgroundColor = UIColor.white
        listView.separatorStyle = .none
        listView.showsVerticalScrollIndicator = false
        listView.showsHorizontalScrollIndicator = false
        listView.estimatedRowHeight = 0
        listView.estimatedSectionHeaderHeight = 0
        listView.estimatedSectionFooterHeight = 0
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
    
    func currentVisibleIndexPath() -> [IndexPath]? {
        return self.listView.indexPathsForVisibleRows;
    }
    
    func scrollToVisibleIndexPath(indexPath: IndexPath?, animated: Bool = false) {
        if let indexPath = indexPath {
            self.listView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.none, animated: animated)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SFileDetailCell", for: indexPath)
        cell.textLabel?.text = file.fileName
        cell.detailTextLabel?.text = file.detailText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
