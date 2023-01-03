//
//  NoteEditorViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 27.12.2022.
//

import SwiftUI

class NoteEditorViewModel: ObservableObject {
    @Published var noteTitle: String
    @Published var noteText: NSAttributedString
    @Published var folderName: String
    
    private var note: Note
    private var folder: NotesFolder
    private var isNewNote: Bool
    
    func saveNote() {
        if isNewNote {
            let note = note
            note.noteTitle = self.noteTitle
            note.date = Date()
            do {
                let data = try noteText.richTextData(for: .archivedData)
                note.note = data
            } catch let error {
                print("Error: \(error)")
            }
            StorageManager.shared.saveNote(note, for: folder)
        } else {
            let note = note
            var archivedData: Data?
            do {
                let data = try noteText.richTextData(for: .archivedData)
                archivedData = data
            } catch let error {
                print("Error: \(error)")
            }
            guard let archivedData = archivedData else { return }
            StorageManager.shared.editNote(note, with: noteTitle, and: archivedData)
            print("Edit note")
        }
    }
    
    
    init(noteData: NoteData) {
        self.noteTitle = noteData.noteTitle
        self.noteText = noteData.noteText
        self.folderName = noteData.noteFolder
        self.note = noteData.note
        self.folder = noteData.folder
        self.isNewNote = noteData.isNewNote
    }
}

