//
//  Note.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import Foundation
import RealmSwift

class Note: Object {
    @Persisted var noteName: String
    @Persisted var date: Date
    @Persisted var note: Data
}
