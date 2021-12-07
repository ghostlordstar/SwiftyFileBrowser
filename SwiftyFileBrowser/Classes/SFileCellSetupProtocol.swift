//
//  SFileCellSetupProtocol.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/12/6.
//

import Foundation

protocol SFileCellSetupProtocol: AnyObject {
    func setupCell(indexPath: IndexPath?, file: SFile)
    static func identifierOfCell() -> String
    func update(fileState: SFileState)
    func registerPreview(delegate: UIViewControllerPreviewingDelegate?)
}
