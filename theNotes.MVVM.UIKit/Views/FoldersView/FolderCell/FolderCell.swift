//
//  FoldersCell.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import UIKit

class FolderCell: UITableViewCell {
    
    static let reuseId = "FolderCell"
    
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var folderName: UILabel!
    @IBOutlet weak var notesCount: UILabel!
    
    var viewModel: FolderCellViewModelProtocol! {
        didSet {
            folderImage.image = UIImage(systemName: viewModel.folderImage)
            folderName.text = viewModel.folderName
            notesCount.text = viewModel.notesCount
        }
    }
}
