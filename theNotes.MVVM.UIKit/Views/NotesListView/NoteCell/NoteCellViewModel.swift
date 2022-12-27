//
//  NoteCellViewModel.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RichTextKit

protocol NoteCellViewModelProtocol {
    var noteTitle: String { get }
    var noteText: NSAttributedString { get }
    var notePreview: NSAttributedString { get }
    var date: Date { get }
    init(note: Note)
}

class NoteCellViewModel: NoteCellViewModelProtocol {
    
    private var note: Note!
    
    var noteTitle: String {
        note.noteName
    }
    
    var noteText: NSAttributedString {
        do {
            let richTextView = try! RichTextView(data: note.note)
            return richTextView.richText
        }
        
    }
    
    var date: Date {
        note.date
    }
    
    var notePreview: NSAttributedString {
        NSAttributedString(string: "\(CalendarHelper.shared.getDateString(date: date)) \(noteText)")
    }
    
    required init(note: Note) {
        self.note = note
    }
}
