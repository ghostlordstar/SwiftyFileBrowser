//
//  SFileBrowserDelegate.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/12/7.
//

import Foundation

public protocol SFileBrowserDelegate: AnyObject {
    func fileDownloadButtonAction(indexPath: IndexPath?, file: SFile)   // download
    func fileTouchAction(indexPath: IndexPath?, file: SFile)            // touch
    func fileLongPressAction(indexPath: IndexPath?, file: SFile) -> UIContextMenuConfiguration? // long press
    func fileDidEndLongPressAction(indexPath: IndexPath?, file: SFile)   // long press end
}
