//
//  EditFolderViewController.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 24.12.2022.
//

import UIKit

class EditFolderViewController: UIViewController {
    
    
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: EditFolderViewModelProtocol! {
        didSet {
            viewModel.getImages()
            viewModel.viewModelDidChange = { [unowned self] viewModel in
                self.viewModel = viewModel
                collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EditFolderViewModel()
        folderNameTextField.text = navigationBar.title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        folderNameTextField.becomeFirstResponder()
        folderNameTextField.selectAll(nil)
    }

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        guard let folderName = folderNameTextField.text else { return }
        viewModel.saveFolder(folderName: folderName)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension EditFolderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderImageCell", for: indexPath)
        guard let cell = cell as? FolderImageCell else { return UICollectionViewCell() }
        cell.folderImageName = viewModel.getFolderImage(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.imageDidSelected(at: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EditFolderViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 6
        let paddingWidth = 1 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
