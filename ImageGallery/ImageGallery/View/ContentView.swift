//
//  ContentView.swift
//  ImageGallery
//
//  Created by Manya on 01/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ImageGridView(viewModel: viewModel())
            .onAppear() {
                //ImageFileManager.shared.clearFileManager()
            }
    }
    
    func viewModel() -> ImageGridViewModel {
        let session = URLSession.shared
        return ImageGridViewModel(imageService: ImageGridServiceAdapter(api: ImageServiceApi(session: session)))
    }
}

#Preview {
    ContentView()
}
