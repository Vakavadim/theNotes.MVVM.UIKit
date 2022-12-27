//
//  StorageManager.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RealmSwift
import RichTextKit

final class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    let realm = try! Realm()
    
    var folderImages: [String] = [
        "folder.fill", "studentdesk",
        "star.fill", "list.star", "person.badge.key", "camera.macro.circle",
        "globe.americas", "airplane.departure", "car", "cart", "brain.head.profile",
        "bolt", "giftcard.fill", "creditcard.and.123", "heart.text.square"
    ]
    
    func saveNotesFolder(_ notesFolder: NotesFolder) {
        try! self.realm.write {
            self.realm.add(notesFolder)
        }
    }
    
    func renameFolder(_ notesFolder: NotesFolder, with newFolderName: String) {
        try! realm.write {
            notesFolder.folderName = newFolderName
        }
    }
    
    func deleteFolder(_ notesFolder: NotesFolder) {
        try! realm.write {
            let notes = notesFolder.notes
            realm.delete(notes)
            realm.delete(notesFolder)
        }
    }
    
    func saveNote(_ note: Note, for notesFolder: NotesFolder) {
        try! realm.write {
            notesFolder.notes.append(note)
            print("add new note")
        }
    }
    
    
    func setStartFolder(exactCountOfNote: Int) {
        if exactCountOfNote == 0 {
            let folder = NotesFolder()
            folder.folderName = "Все заметки"
            folder.folderImage = "folder.fill"
            
            let note = Note()
            note.noteName = "Добро пожаловать в заметки"
            
            let NoteAttributedString = NSAttributedString(string: "В этом приложении вы можете создавать заметки и распределять их по папкам")
            do {
                let data = try NoteAttributedString.richTextData(for: .archivedData)
                note.note = data
            } catch let error {
                print("Error: \(error)")
            }
            
            folder.notes.append(note)
            saveNotesFolder(folder)
        } else {
            return
        }
    }
}
