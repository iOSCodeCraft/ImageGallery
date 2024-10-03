//
//  ImageGridViewModel.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//

import SwiftUI
import Foundation

class ImageGridViewModel: ObservableObject {
    private let imageService: ImageServiceProtocol
    private var parentimages: [ImageModel] = []
    @Published var images: [ImageModel] = []
    @Published var error: String?
    var isLoading: Bool = false
    var currentPage: Int = 0

    init(imageService: ImageServiceProtocol) {
        self.imageService = imageService
        loadImages()
    }
    
    func loadImages() {
        guard !isLoading else { return }
        isLoading = true
        currentPage += 1
        let url = "https://jsonplaceholder.typicode.com/photos?_limit=50&_page=\(currentPage)"
        imageService.fetchImages(url: url) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let images):
                    self?.parentimages.append(contentsOf: images)
                    guard let allImages = self?.parentimages else { return }
                    self?.images = Array(allImages.reversed())
                    
                case .failure(let error):
                    self?.error = "Error fetching images: \(error.description)"
                }
            }
        }
    }
}
