//
//  FolderImageCellViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.12.2022.
//

import Foundation

protocol FolderImageCellViewModelProtocol {
    var image: String { get }
    var selectedIndicator: Bool { get }
    init(image: String, isSelected: Bool)
}

class FolderImageCellViewModel: FolderImageCellViewModelProtocol {
    var image: String
    
    var selectedIndicator: Bool
    
    required init(image: String, isSelected: Bool) {
        self.image = image
        self.selectedIndicator = isSelected
    }
}
