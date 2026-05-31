//
// DocumentScaningWrapper.swift
// LearningSwiftUI
//
//  Created by David Martin on 2026-05-31.
//


import SwiftUI
import VisionKit

struct DocumentScaningWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = VNDocumentCameraViewController

    @Binding var scannedImages: [ImageDocItem]
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let scanner = VNDocumentCameraViewController()
        scanner.delegate = context.coordinator
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannedImages: $scannedImages, dismiss: dismiss)
    }
    
}

class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
    @Binding var scannedImages: [ImageDocItem]
    var dismiss: DismissAction
    
    init(scannedImages: Binding<[ImageDocItem]>, dismiss: DismissAction) {
        self._scannedImages = scannedImages
        self.dismiss = dismiss
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for page in 0..<scan.pageCount {
            let item = ImageDocItem(docImage: scan.imageOfPage(at: page))
            scannedImages.append(item)
        }
        dismiss()
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        dismiss()
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: any Error) {
        print(error.localizedDescription)
        dismiss()
    }
    
}

