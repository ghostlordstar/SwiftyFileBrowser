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

    override func viewDidLoad() {
        super.viewDidLoad()

        let sfbView = SFileBrowserView.init(frame: UIScreen.main.bounds)
        let files = [
            FileObject.init(id: "111", name: "name111", detail: "2021/09/11"),
            FileObject.init(id: "222", name: "name222", detail: "2021/09/13"),
            FileObject.init(id: "333", name: "name333", detail: "2021/09/14"),
            FileObject.init(id: "444", name: "name444", detail: "2021/09/14"),
            FileObject.init(id: "555", name: "name555", detail: "2021/09/15"),
            FileObject.init(id: "666", name: "name666", detail: "2021/09/16")
        ]
        sfbView.reloadBrowser(files: files)
        self.view.addSubview(sfbView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

