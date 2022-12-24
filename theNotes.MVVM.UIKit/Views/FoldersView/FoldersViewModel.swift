//
//  FoldersViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RealmSwift

protocol FoldersViewModelProtocol {
    var viewModelDidChange: ((FoldersViewModelProtocol) -> Void)? { get set }
    func numbersOfRows() -> Int
    func getNotesFolder()
    func setStartedFolder()
    func getFolderCellViewModel(at indexPath: IndexPath) -> FolderCellViewModelProtocol
}

class FoldersViewModel: FoldersViewModelProtocol {
    private var folders: [FolderCellViewModelProtocol] = [] {
        didSet {
            viewModelDidChange?(self)
            print("viewModelDidChange?(self)")
            
        }
    }
    
    var viewModelDidChange: ((FoldersViewModelProtocol) -> Void)?
    
    func setStartedFolder() {
        StorageManager.shared.setStartFolder(exactCountOfNote: folders.count)
        print("setStartedFolder()")
        getNotesFolder()
        print("setStartedFolder() -> getNotesFolder()")
    }
    
    func getNotesFolder() {
        let notesFolders = StorageManager.shared.realm.objects(NotesFolder.self)
        self.folders = notesFolders.map {
            FolderCellViewModel(notesFolder: $0)
        }
    }
    
    func numbersOfRows() -> Int {
        folders.count
    }
    
    func getFolderCellViewModel(at indexPath: IndexPath) -> FolderCellViewModelProtocol {
        folders[indexPath.row]
    }
}


