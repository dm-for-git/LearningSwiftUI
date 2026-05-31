//
// ViewModel.swift
// LearningSwiftUI
//
//  Created by David Martin on 2026-05-31.
//


import UIKit
import SwiftUI
import Combine

@MainActor
class DocScannerViewModel: ObservableObject {
    
    @Published var scannedImages: [ImageDocItem]
    @Published var currentIndex: Int = 0 {
        didSet {
            validateAndBoundIndex()
        }
    }
    
    init(images: [ImageDocItem] = []) {
        self.scannedImages = images
    }
    
    // MARK: Public API
    func updateImages(_ newImages: [ImageDocItem]) {
        self.scannedImages = newImages
        if currentIndex >= newImages.count {
            currentIndex = max(0, newImages.count - 1)
        }
    }
    
    func nextImage() {
        guard !scannedImages.isEmpty else { return }
        if currentIndex < scannedImages.count - 1 {
            currentIndex += 1
        }
    }
    
    func previousImage() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func resetData() {
        scannedImages = []
    }
    
    // MARK: Private Helpers
    private func validateAndBoundIndex() {
        guard !scannedImages.isEmpty else {
            currentIndex = 0
            return
        }
        if currentIndex < 0 {
            currentIndex = 0
        } else if currentIndex >= scannedImages.count {
            currentIndex = scannedImages.count - 1
        }
    }
}
