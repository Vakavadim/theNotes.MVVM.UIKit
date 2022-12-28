//
//  NoteData.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 28.12.2022.
//

import Foundation

struct NoteData {
    let noteTitle: String
    let noteText: NSAttributedString
    let noteFolder: String
    let isNewNote: Bool
    let folder: NotesFolder
    let note: Note
}
