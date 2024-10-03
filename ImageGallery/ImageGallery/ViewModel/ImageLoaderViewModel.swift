//
//  ImageLoaderViewModel.swift
//  ImageGallery
//
//  Created by Manya on 03/10/24.
//
import SwiftUI

class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var error: String? = nil
    @Published var isLoading: Bool = false

    func loadImage(from urlString: String) {
        isLoading = true
        ImageDownloadManager.shared.downloadImage(from: urlString, completion: { result in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                switch result {
                case .success(let idImage):
                    self?.image = idImage
                case .failure(let error):
                    self?.error = error.description
                }
            }
        })
    }
}
