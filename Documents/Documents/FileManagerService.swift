//
//  FileManagerService.swift
//  Documents
//
//  Created by Artur Skaliy on 15.10.2022.
//

import Foundation
import UIKit

class FileManagerService: FileManagerServiceProtocol {


    func contentsOfDirectory(currentDirectory: URL) -> [URL] {
        var contents: [URL] = []
            do {
                let files = try FileManager.default.contentsOfDirectory(at: currentDirectory, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                contents = files
                
            } catch {
                print("ERROR contentsOfDirectory")
            }
        return contents
    }
            
    
    func createDirectory(currentDirectory: URL, newDirectoryName: String) {
        let newDirectoryURL = currentDirectory.appendingPathComponent(newDirectoryName)
        do {
            try FileManager.default.createDirectory(atPath: newDirectoryURL.path, withIntermediateDirectories: false)
        } catch {
            print("createDirectory error: \(error.localizedDescription)")
        }
    }
    
    func createFile(currentDirectory: URL, newFile: URL, image: UIImage) {
        let fileURL = currentDirectory.appendingPathComponent(newFile.lastPathComponent)
        do {
            FileManager.default.createFile(atPath: fileURL.path, contents: image.jpegData(compressionQuality: 1))
        }
    }
    
    func removeContent(currentDirectory: URL, toDelete: URL) {
        do {
            try FileManager.default.removeItem(at: toDelete)
        } catch {
            print("removeContent error: \(error.localizedDescription)")
        }
    }
}
