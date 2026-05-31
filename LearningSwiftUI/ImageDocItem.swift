//
// ImageDocItem.swift
// LearningSwiftUI
//
//  Created by David Martin on 2026-05-31.
//  


import UIKit

// MARK: - Model
struct ImageDocItem: Identifiable, Equatable {
    let id: UUID = UUID()
    let docImage: UIImage
}
