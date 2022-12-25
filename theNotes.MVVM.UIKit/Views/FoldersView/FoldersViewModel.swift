//
//  FoldersViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import RealmSwift
import UIKit

protocol FoldersViewModelProtocol {
    var folderNameDidChage: Bool { get set }
    var viewModelDidChange: ((FoldersViewModelProtocol) -> Void)? { get set }
    func numbersOfRows() -> Int
    func getNotesFolders()
    func setStartedFolder()
    func getCurrentFolder(at indexPath: IndexPath) -> NotesFolder
    func getFolderCellViewModel(at indexPath: IndexPath) -> FolderCellViewModelProtocol
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction
    func renameAction(at indexPath: IndexPath, viewController: UIViewController) -> UIContextualAction
    func renameFolder(at indexPath: IndexPath, viewController: UIViewController)
}

class FoldersViewModel: FoldersViewModelProtocol {
    
    private var folderNameDidChaged = false
    
    private var folders: [FolderCellViewModelProtocol] = [] {
        didSet {
            viewModelDidChange?(self)
        }
    }
    
    var folderNameDidChage: Bool {
        get {
            folderNameDidChaged
        } set {
            folderNameDidChaged = newValue
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((FoldersViewModelProtocol) -> Void)?
    
    func getCurrentFolder(at indexPath: IndexPath) -> NotesFolder {
        let notesFolders = StorageManager.shared.realm.objects(NotesFolder.self)
        let currentFolder = notesFolders[indexPath.row]
        return currentFolder
    }
    
    func setStartedFolder() {
        StorageManager.shared.setStartFolder(exactCountOfNote: folders.count)
        getNotesFolders()
    }
    
    func getNotesFolders() {
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
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, _ in
            guard let self = self else {return}
            let currentFolder = self.getCurrentFolder(at: indexPath)
            StorageManager.shared.deleteFolder(currentFolder)
            self.getNotesFolders()
        }
        return deleteAction
    }
    
    func renameAction(at indexPath: IndexPath, viewController: UIViewController) -> UIContextualAction {
        let renameAction = UIContextualAction(style: .normal, title: "Переимновать") { [weak self] _, _, _ in
            guard let self = self else {return}
            self.renameFolder(at: indexPath, viewController: viewController)
            print("rename")
        }
        return renameAction
    }
    
    func renameFolder(at indexPath: IndexPath, viewController: UIViewController) {
        let currentFolder = getCurrentFolder(at: indexPath)
        let alert = UIAlertController(title: "Переименовывание папки", message: nil, preferredStyle: .alert)
        var folderNameTextField:UITextField!
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive)
        let renameAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            guard let self = self else {return}
            guard let text = folderNameTextField.text, !text.isEmpty else { return }
            StorageManager.shared.renameFolder(currentFolder, with: text)
            self.getNotesFolders()
            self.folderNameDidChage.toggle()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(renameAction)
        
        alert.addTextField { textField in
            folderNameTextField = textField
            folderNameTextField.text = currentFolder.folderName
            folderNameTextField.becomeFirstResponder()
            folderNameTextField.selectAll(nil)
        }
        viewController.present(alert, animated: true)
    }
}


