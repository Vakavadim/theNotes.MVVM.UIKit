//
//  NotesListViewController.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import UIKit

class NotesListViewController: UIViewController {
    
    var viewModel: NotesListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.folderName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
