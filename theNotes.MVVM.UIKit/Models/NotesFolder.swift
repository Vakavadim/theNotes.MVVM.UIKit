//
//  NotesFolder.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RealmSwift

class NotesFolder: Object {
    @Persisted var folderName: String
    @Persisted var folderImage: String
    @Persisted var notes = List<Note>()
}
