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
    func getNoteCellViewModel(at indexPath: IndexPath) -> NoteCellViewModelProtocol
    func getNoteEditorViewModelForNewNote() -> NoteEditorViewModel
    func getNoteEditorViewModel(at indexPath: IndexPath) -> NoteEditorViewModel
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
    
    func getNoteCellViewModel(at indexPath: IndexPath) -> NoteCellViewModelProtocol {
        NoteCellViewModel(note: folder.notes[indexPath.row])
    }
    
    func getNoteEditorViewModelForNewNote() -> NoteEditorViewModel {
        NoteEditorViewModel(note: Note(), folderName: folderName)
    }
    
    func getNoteEditorViewModel(at indexPath: IndexPath) -> NoteEditorViewModel {
        NoteEditorViewModel(note: folder.notes[indexPath.row], folderName: folderName)
    }
    
    required init(notesFolder: NotesFolder) {
        self.folder = notesFolder
    }
}
