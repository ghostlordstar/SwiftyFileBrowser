//
//  SFileCellActionProtocol.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/12/7.
//

import Foundation

protocol SFileCellActionProtocol: AnyObject {
    func fileDownloadAction(indexPath: IndexPath?, file: SFile)
    func fileLongTouchAction(indexPath: IndexPath?, file: SFile)
    func fileTouchAction(indexPath: IndexPath?, file: SFile)
}
