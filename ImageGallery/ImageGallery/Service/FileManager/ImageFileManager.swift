//
//  ImageFileManager.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//

import Foundation
import SwiftUI

class ImageFileManager {
    
    static let shared = ImageFileManager()
    private init() {
        createFolderIfNeeded()
    }
    
    func getFolderPath() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("ImageGallery_Cache")
    }
    func createFolderIfNeeded() {
        
        guard let url = getFolderPath() else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("Folder created successfully")
            }catch let err {
                print("Error creating directory: \(err.localizedDescription)")
            }
            
        } else {
            print("Directory already exists")
        }
    }
    
    func getImagePath(with url: String) -> URL? {
        let key = getUniqueKey(from: url)
       guard let folderPath = getFolderPath() else { return nil }
       return folderPath.appendingPathComponent(key)
    }
    
    func addImage(_ image: UIImage, with url: String) {
        let key = getUniqueKey(from: url)
        guard let data = image.pngData() else { return }
        guard let url = getImagePath(with: key) else { return }
        do {
            try data.write(to: url)
            print("Added image to File Manager")
        }catch let err {
            print("Error saving image in File Manager: \(err.localizedDescription)")
        }
    }
    func getImage(with url: String) -> UIImage? {
        let key = getUniqueKey(from: url)
        guard let url = getImagePath(with: key) else { return nil }
        guard let image = UIImage(contentsOfFile: url.path) else { return nil }
        print("Image From File Manager: \(url.path)")
        return image
    }
    
    func clearFileManager() {
        guard let folderPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("ImageGallery_Cache") else { return }
        do {
            try FileManager.default.removeItem(at: folderPath)
                print("Directory clear")
        } catch let err {
            print("Error is deleting cache folder: \(err.localizedDescription)")
        }
    }
    
    func getUniqueKey(from url: String) -> String {
        var key = url.replacingOccurrences(of: "https://via.placeholder.com/", with: "")
        key = key.replacingOccurrences(of: "/", with: "")
        return key
    }
}
