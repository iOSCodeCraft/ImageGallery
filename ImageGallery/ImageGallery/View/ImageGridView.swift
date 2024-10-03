//
//  ImageGridView.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//
import SwiftUI



struct ImageGridView: View {
    
    @StateObject var viewModel: ImageGridViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if self.viewModel.isLoading {
                   ProgressView()
               }
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 1) { 
                        ForEach(viewModel.images) { image in
                            NavigationLink(destination: ImageDetailView(viewModel: viewModel, currentIndex: viewModel.images.firstIndex(of: image) ?? 0)) {
                                ImageGridCell(imageURL: image.thumbnailUrl)
                            }
                        }
                    }
                }
                .refreshable {
                    self.viewModel.loadImages()  // Pull to refresh action
                }
            }
            .navigationTitle("Image Gallery")
        }
    }
    
}


#Preview {
    ImageGridView(viewModel: ImageGridViewModel(imageService: ImageGridServiceAdapter(api: ImageServiceApi(session: URLSession.shared))))
}
