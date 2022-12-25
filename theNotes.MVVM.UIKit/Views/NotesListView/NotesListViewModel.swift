//
//  NotesListViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RealmSwift

protocol NotesListViewModelProtocol {
    var folderName: String { get }
    func getNotesCount() -> Int
    init(notesFolder: NotesFolder)
}

class NotesListViewModel: NotesListViewModelProtocol {
    
    private var folder: NotesFolder
    
    var folderName: String {
        folder.folderName
    }
    
    func getNotesCount() -> Int {
        folder.notes.count
    }
    
    required init(notesFolder: NotesFolder) {
        self.folder = notesFolder
    }
}
