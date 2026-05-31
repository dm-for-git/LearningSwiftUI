//
//  Created by David Martin on 2026-02-26.
//

import SwiftUI
import VisionKit

struct DocScannerView: View {
    
    @StateObject var viewModel = DocScannerViewModel()
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack {
            if !viewModel.scannedImages.isEmpty {
                TabView(selection: $viewModel.currentIndex) {
                    ForEach(Array(viewModel.scannedImages.enumerated()), id: \.element.id) { index, item in
                        Image(uiImage: item.docImage)
                            .resizable()
                            .scaledToFill()
                            .tag(index)
                            .clipped()
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            } else {
                Text("No document scanned yet")
                    .foregroundColor(.gray)
            }
            
            Button("Scan Document") {
                viewModel.resetData()
                isShowingScanner = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(20)
        .fullScreenCover(isPresented: $isShowingScanner, content: {
            DocumentScaningWrapper(scannedImages: $viewModel.scannedImages)
        })
    }
}

//#Preview {
//    ContentView()
//}
