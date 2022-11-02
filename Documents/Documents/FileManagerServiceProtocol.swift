//
//  FileManagerServiceProtocol.swift
//  Documents
//
//  Created by Artur Skaliy on 15.10.2022.
//

import Foundation
import UIKit


protocol FileManagerServiceProtocol {
    func contentsOfDirectory(currentDirectory: URL) -> [URL]
    func createDirectory(currentDirectory: URL, newDirectoryName: String)
    func createFile(currentDirectory: URL, newFile: URL, image: UIImage)
    func removeContent(currentDirectory: URL, toDelete: URL)
}
