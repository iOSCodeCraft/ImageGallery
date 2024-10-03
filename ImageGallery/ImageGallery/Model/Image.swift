//
//  Image.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//


struct ImageModel: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
        
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case thumbnailUrl
    }
}

