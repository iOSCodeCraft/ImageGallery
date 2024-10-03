//
//  ImageServiceProtocol.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//
import Foundation

enum ApiError: Error {
    case noInternetConnection
    case invalidUrl
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
    case unknownError
    case custom(String)
    
    var description: String {
        switch self {
        case .noInternetConnection: return "No Internet Connection. Please check your internet connection."
        case .invalidUrl: return "Invalid URL"
        case .invalidResponse: return "Invalid Response"
        case .invalidData: return "Invalid Data"
        case .decodingError: return "Decoding Error"
        case .serverError: return "Server Error"
        case .unknownError: return "Something went wrong. Please try again later."
        case .custom(let message): return message
        }
    }
}
protocol ImageServiceProtocol {
    func fetchImages(url: String, completion: @escaping (Result<[ImageModel], ApiError>) -> Void)
}

struct ImageGridServiceAdapter: ImageServiceProtocol {
    let api: ImageServiceApi
    func fetchImages(url: String, completion: @escaping (Result<[ImageModel], ApiError>) -> Void) {
        guard let url = URL(string: url) else { return }
        api.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode([ImageModel].self, from: data)
                    completion(.success(images))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct ImageServiceApi {
    let session: URLSession
    
    func fetchData(url: URL, completion: @escaping (Result<Data, ApiError>) -> Void) {
        self.session.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(.serverError))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
