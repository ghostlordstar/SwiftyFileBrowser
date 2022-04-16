//
//  ViewController.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 11/24/2021.
//  Copyright (c) 2021 Hansen. All rights reserved.
//

import UIKit
import SwiftyFileBrowser

class ViewController: UIViewController {

    var sfbView: SwiftyFileBrowser?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(p_swiftchListType))
        self.sfbView = SwiftyFileBrowser.init(frame: CGRect.init(x: 0, y: SFFit.navWithStatusBarHeight, width: SFFit.width, height: SFFit.height - SFFit.navWithStatusBarHeight), type: .icons)
        self.sfbView?.delegate = self
        let files = [
            FileObject.init(id: "111", type: .folder, name: "name111434534534534523423535436346awefasdfas", detail: "2021/09/11-asdgsfgfadsfadfadfasdfadfadfadfadf"),
            FileObject.init(id: "222", name: "name222", detail: "2021/09/13"),
            FileObject.init(id: "333", name: "name333", detail: "2021/09/14"),
            FileObject.init(id: "444", type: .unknow, name: "name444", detail: "2021/09/14"),
            FileObject.init(id: "555", name: "name555", detail: "2021/09/15"),
            FileObject.init(id: "666", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "777", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "888", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "999", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "000", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "1000", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "1001", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "1002", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "1003", name: "name666", detail: "2021/09/16"),
            FileObject.init(id: "1004", name: "name666", detail: "2021/09/16"),
        ]
        
        // Long press Actions
        let copyEle = UIAction.init(title: "Copy", image: nil, identifier: UIAction.Identifier.init("LongPress-Copy"), discoverabilityTitle: nil, attributes: [], state: .off) { act in
            print("LongPress copy event!,index: \(self.sfbView?.longPressIndex)")
            // TODO: copy logic
        }
        
        let moveEle = UIAction.init(title: "Move", image: nil, identifier: UIAction.Identifier.init("LongPress-Move"), discoverabilityTitle: nil, attributes: [], state: .off) { act in
            print("LongPress Move event!,index: \(self.sfbView?.longPressIndex)")
            // TODO: Move logic
        }
        
        self.sfbView?.longPressMenuElements = [copyEle, moveEle]
        
        self.sfbView?.reloadBrowser(files: files)
        self.view.addSubview(self.sfbView!)
        
//        self.testFileType()
    }

    @objc func p_swiftchListType() {
        self.sfbView?.switchTo()
    }
    
//    func testFileType() {
//        // 不相等
//        var type1: SFileType = .folder
//        var type2: SFileType = .html
//        if case type1 = type2 {
//            print("folder == html")
//        }else {
//            print("folder != html")
//        }
//        // 相等
//        type1 = .folder
//        type2 = .folder
//        if case type1 = type2 {
//            print("folder == folder")
//        }else {
//            print("folder != folder")
//        }
//        // 关联值不相等
//        type1 = .image(format: "a")
//        type2 = .image(format: "b")
//        if case type1 = type2 {
//            print("image.a == image.b")
//        }else {
//            print("image.a != image.b")
//        }
//        // 完全相等
//        type1 = .image(format: "a")
//        type2 = .image(format: "a")
//        if case type1 = type2 {
//            print("image.a == image.a")
//        }else {
//            print("image.a != image.a")
//        }
//        // 类型不相等
//        type1 = .image(format: "a")
//        type2 = .folder
//        if case type1 = type2 {
//            print("image.a == folder")
//        }else {
//            print("image.a != folder")
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: SFileBrowserDelegate {
    func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile) {
        print("\(#function)")
    }
    
    func fileLongTouchAction(indexPath: IndexPath?, file: SFile) {
        print("\(#function)")
    }
    
    func fileTouchAction(indexPath: IndexPath?, file: SFile) {
        print("\(#function)")
    }
}
