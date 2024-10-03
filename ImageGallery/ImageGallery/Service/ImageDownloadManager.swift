//
//  ImageDownloadManager.swift
//  ImageGallery
//
//  Created by Manya on 02/10/24.
//
import Foundation
import UIKit


struct DownloadImageServiceAdapter {
    let apiService: ImageServiceApi
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage, ApiError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        apiService.fetchData(url: url) { result in
            switch result {
                case .success(let data):
                if let uiImage = UIImage(data: data) {
                    ImageFileManager.shared.addImage(uiImage, with: urlString)
                    completion(.success(uiImage))
                } else {
                    completion(.failure(.invalidData))
                }
                
                case .failure(let error):
                    completion(.failure(error))
            }
            
        }
    }
}
class ImageDownloadManager {
    
    lazy var queue: OperationQueue = {
        let qu = OperationQueue()
        qu.maxConcurrentOperationCount = 4
        return qu
    }()
    
    lazy var session: URLSession = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 20
            return URLSession(configuration: configuration, delegate: nil, delegateQueue: queue)
    }()
    
    static var shared: ImageDownloadManager = ImageDownloadManager()
    private init() { }
   
    func downloadImage(from imageUrl: String, completion: @escaping (Result<UIImage, ApiError>) -> Void) {
        queue.addOperation {
            if let image = ImageFileManager.shared.getImage(with: imageUrl) {
                completion(.success(image))
                return
            }
            DownloadImageServiceAdapter(apiService: ImageServiceApi(session: self.session)).downloadImage(urlString: imageUrl) { result in
                completion(result)
            }
        }
    }
    
}



