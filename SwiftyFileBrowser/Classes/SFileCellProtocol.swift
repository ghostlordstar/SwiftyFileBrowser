//
//  SFileCellProtocol.swift
//  SwiftyFileBrowser
//
//  Created by Hansen on 2021/12/6.
//

import Foundation

protocol SFileCellProtocol {
    func setupCell(indexPath: IndexPath?, file: SFile)
    static func identifierOfCell() -> String
}
