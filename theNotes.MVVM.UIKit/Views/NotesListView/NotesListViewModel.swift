//
//  NotesListViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RealmSwift
import RichTextKit

protocol NotesListViewModelProtocol {
    var folderName: String { get }
    func getNotesCount() -> Int
    func getNoteCellViewModel(at indexPath: IndexPath) -> NoteCellViewModelProtocol
    func getNoteDataForNewNote() -> NoteData
    func getNoteData(at indexPath: IndexPath) -> NoteData
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
   
    func getNoteDataForNewNote() -> NoteData {
        let data = NoteData(noteTitle: "", noteText: NSAttributedString.empty, noteFolder: folderName, isNewNote: true, folder: folder, note: Note())
        return data
    }
    
    func getNoteData(at indexPath: IndexPath) -> NoteData {
        var noteText = NSAttributedString.empty
        do {
            let richTextView = try! RichTextView(data: folder.notes[indexPath.row].note)
            noteText = richTextView.richText
        }
        let data = NoteData(noteTitle:  folder.notes[indexPath.row].noteTitle,
                            noteText: noteText,
                            noteFolder: folderName,
                            isNewNote: false,
                            folder: folder,
                            note: folder.notes[indexPath.row]
            )
        return data
    }
    
    required init(notesFolder: NotesFolder) {
        self.folder = notesFolder
    }
}
