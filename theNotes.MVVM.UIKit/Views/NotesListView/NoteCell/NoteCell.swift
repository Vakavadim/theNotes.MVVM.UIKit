//
//  NoteCell.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notePreviewLabel: UILabel!
    
    var viewModel: NoteCellViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.noteTitle
            notePreviewLabel.attributedText = viewModel.notePreview
        }
    }
}
