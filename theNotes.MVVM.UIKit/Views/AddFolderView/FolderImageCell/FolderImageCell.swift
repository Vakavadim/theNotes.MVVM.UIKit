//
//  FolderImageCell.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.12.2022.
//

import UIKit

class FolderImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: FolderImageCellViewModelProtocol! {
        didSet {
            imageView.image = UIImage(systemName: viewModel.image)
            imageView.tintColor = viewModel.selectedIndicator ? .white : .tintColor
            backgroundColor = viewModel.selectedIndicator ? .gray : .white
        }
    }
}
