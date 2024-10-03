//
//  ImageDetailView.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//

import SwiftUI

struct ImageDetailView: View {
    @StateObject var viewModel: ImageGridViewModel
    @State var currentIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.images[currentIndex].title)
                .font(.headline)
                .padding(.leading, 20)
                .lineLimit(2)
            TabView(selection: $currentIndex) {
                ForEach(0..<viewModel.images.count, id: \.self) { index in
                    VStack{
                        let image = viewModel.images[index]
                        ImageGridCell(imageURL: image.url)
                    }.tag(index)
                }
            }
            .animation(.easeInOut, value: currentIndex)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            Spacer()
        }
        .navigationTitle("Image Detail")
    }
}

#Preview {
    let previewimage = [ImageModel(
        id: 1,
        title: "autem accusamus et quo sequi consequatur pariatur odio",
        url: "https://via.placeholder.com/600/544ea7",
        thumbnailUrl: "https://via.placeholder.com/150/544ea7")]
    ImageDetailView(viewModel: ImageGridViewModel(imageService: ImageGridServiceAdapter(api: ImageServiceApi(session: URLSession.shared))), currentIndex: 0)
}



