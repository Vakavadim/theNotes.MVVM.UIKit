//
//  FolderImageCell.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.12.2022.
//

import UIKit

class FolderImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var folderImageName: String = "" {
        didSet {
            imageView.image = UIImage(systemName: folderImageName)
            
        }
    }
}
