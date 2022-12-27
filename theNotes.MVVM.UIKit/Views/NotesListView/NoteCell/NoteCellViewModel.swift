//
//  NoteCellViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation

protocol NoteCellViewModelProtocol {
    var noteTitle: String { get }
    var noteText: String { get }
    var notePreview: String { get }
    var date: Date { get }
    init(note: Note)
}

class NoteCellViewModel: NoteCellViewModelProtocol {
    
    private var note: Note!
    
    var noteTitle: String {
        note.noteName
    }
    
    var noteText: String {
        note.note
    }
    
    var date: Date {
        note.date
    }
    
    var notePreview: String {
        "\(CalendarHelper.shared.getDateString(date: date)) \(noteText)"
    }
    
    required init(note: Note) {
        self.note = note
    }
}
