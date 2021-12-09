//
//  SFileBrowserDelegate.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/12/7.
//

import Foundation

public protocol SFileBrowserDelegate: AnyObject {
    func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile)   // download
    func fileLongTouchAction(indexPath: IndexPath?, file: SFile)        // long press
    func fileTouchAction(indexPath: IndexPath?, file: SFile)            // touch
}
