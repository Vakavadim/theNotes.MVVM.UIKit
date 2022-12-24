//
//  ViewController.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import UIKit

class FoldersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: FoldersViewModelProtocol! {
        didSet {
            viewModel.getNotesFolder()
            viewModel.setStartedFolder()
            viewModel.viewModelDidChange = { [unowned self] viewModel in
                self.viewModel = viewModel
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableViewCell()
        viewModel = FoldersViewModel()
    }
    
    @IBAction func editButton(_ sender: Any) {
    }
    @IBAction func addFolder(_ sender: Any) {
    }
    @IBAction func addNote(_ sender: Any) {
    }
    
    private func setupUI() {
        title = "Папки"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableViewCell() {
        let nib = UINib(nibName: "FolderCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FolderCell")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FoldersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath)
        guard let cell = cell as? FolderCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getFolderCellViewModel(at: indexPath)
        return cell
    }
}
