//
//  EditFolderViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.12.2022.
//

import Foundation

protocol EditFolderViewModelProtocol {
    var viewModelDidChange: ((EditFolderViewModelProtocol) -> Void)? { get set }
    var selectedImage: String { get set }
    func getImages()
    func imageDidSelected(at indexPath: IndexPath)
    func getItemsCount() -> Int
    func getFolderImage(at indexPath: IndexPath) -> String
    func saveFolder(folderName: String)
}

class EditFolderViewModel: EditFolderViewModelProtocol {
    
    private var images: [String] = [] {
        didSet {
            viewModelDidChange?(self)
        }
    }
    
    private var defaultImage = "folder.fill"
    
    var viewModelDidChange: ((EditFolderViewModelProtocol) -> Void)?
    
    var selectedImage: String {
        get {
            defaultImage
        } set {
            defaultImage = newValue
            viewModelDidChange?(self)
        }
    }

    func imageDidSelected(at indexPath: IndexPath) {
        selectedImage = images[indexPath.item]
    }
    
    func getImages() {
        self.images = StorageManager.shared.folderImages
    }
    
    func getItemsCount() -> Int {
        images.count
    }
    
    func getFolderImage(at indexPath: IndexPath) -> String {
        images[indexPath.item]
    }
    
    func saveFolder(folderName: String) {
        let folder = NotesFolder()
        folder.folderName = folderName
        folder.folderImage = selectedImage
        StorageManager.shared.saveNotesFolder(folder)
    }
    
    
}
