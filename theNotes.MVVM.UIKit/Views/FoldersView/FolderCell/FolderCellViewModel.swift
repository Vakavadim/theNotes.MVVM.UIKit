//
//  FoldersCellViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation

protocol FolderCellViewModelProtocol {
    var folderName: String { get }
    var folderImage: String { get }
    var notesCount: String { get }
    var notes: [Note] { get }
    init(notesFolder: NotesFolder)
}

class FolderCellViewModel: FolderCellViewModelProtocol {
    
    
    private let notesFolder: NotesFolder
    
    var folderName: String {
        notesFolder.folderName
    }
    
    var folderImage: String {
        notesFolder.folderImage
    }
    
    var notesCount: String {
        notesFolder.notes.count.formatted()
    }
    
    var notes: [Note] {
        var notes: [Note] = []
        for note in notesFolder.notes {
            notes.append(note)
        }
        return notes
    }
    
    required init(notesFolder: NotesFolder) {
        self.notesFolder = notesFolder
    }
}
