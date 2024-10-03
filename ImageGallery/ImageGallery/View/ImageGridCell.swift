//
//  ImageGridCell.swift
//  ImageGallery
//
//  Created by Manya on 02/10/24.
//
import SwiftUI

struct ImageGridCell: View {
    
    @StateObject private var loader = ImageLoaderViewModel()
    
    let imageURL: String
    @State private var image: UIImage? = nil
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
    var body: some View {
        ZStack{
            if let image = loader.image {
                
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    .scaledToFit()
            } else {
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(.systemGray5))
                        .aspectRatio(contentMode: .fit)
                    
                    if let _ = loader.error {
                        if !loader.isLoading {
                            Button(action: {
                                loader.loadImage(from: imageURL)
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .tint(.red)
                            }
                        } else {
                            ProgressView()
                        }
                    }
                }
            }
        }.onAppear {
            loader.loadImage(from: imageURL)
        }
    }
}

#Preview {
    ImageGridCell(imageURL: "https://picsum.photos/200/300")
}
