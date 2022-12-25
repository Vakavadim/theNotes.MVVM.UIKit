//
//  EditFolderViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.12.2022.
//

import Foundation

protocol AddFolderViewModelProtocol {
    var viewModelDidChange: ((AddFolderViewModelProtocol) -> Void)? { get set }
    var selectedImage: String { get set }
    func getImages()
    func imageDidSelected(at indexPath: IndexPath)
    func getItemsCount() -> Int
    func getFolderImageCellViewModel(at indexPath: IndexPath) -> FolderImageCellViewModelProtocol
    func saveFolder(folderName: String)
}

class AddFolderViewModel: AddFolderViewModelProtocol {
    
    private var images: [String] = [] {
        didSet {
            viewModelDidChange?(self)
        }
    }
    
    private var defaultImage = "folder.fill"
    
    var viewModelDidChange: ((AddFolderViewModelProtocol) -> Void)?
    
    var selectedImage: String {
        get {
            defaultImage
        } set {
            defaultImage = newValue
//            viewModelDidChange?(self)
            print("new value \(newValue)")
        }
    }

    func imageDidSelected(at indexPath: IndexPath) {
        self.selectedImage = images[indexPath.item]
    }
    
    func getImages() {
        self.images = StorageManager.shared.folderImages
    }
    
    func getItemsCount() -> Int {
        images.count
    }
    
    func getFolderImageCellViewModel(at indexPath: IndexPath) -> FolderImageCellViewModelProtocol {
        let imageString = images[indexPath.item]
        let isSelected = imageString == selectedImage
        let viewModel = FolderImageCellViewModel(image: imageString, isSelected: isSelected)
        return viewModel
    }
    
    func saveFolder(folderName: String) {
        let folder = NotesFolder()
        folder.folderName = folderName
        folder.folderImage = selectedImage
        StorageManager.shared.saveNotesFolder(folder)
    }
    
    
}
