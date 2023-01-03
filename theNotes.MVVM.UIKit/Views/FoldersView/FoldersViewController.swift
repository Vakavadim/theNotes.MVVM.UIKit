//
//  ViewController.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import SwiftUI

protocol FoldersViewControllerDelegate: AnyObject {
    func reloadTableViewData()
}

class FoldersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    private var viewModel: FoldersViewModelProtocol! {
        didSet {
            viewModel.getNotesFolders()
            viewModel.setStartedFolder()
            viewModel.viewModelDidChange = { [unowned self] viewModel in
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
    
    @IBSegueAction func addNewNote(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: NoteEditorView(
            viewModel: NoteEditorViewModel(
                noteData: self.viewModel.getNoteDataForNewNote()
                )
            )
        )
    }
    
    @IBAction func editButton(_ sender: Any) {
        turnEditing()
    }
    @IBAction func addFolder(_ sender: Any) {
    }
    @IBAction func addNote(_ sender: Any) {
    }
    
    private func setupTableViewCell() {
        let nib = UINib(nibName: "FolderCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FolderCell")
    }
    
    
    private func turnEditing() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            if self.tableView.isEditing {
                self.editButton.title = "Править"
                self.tableView.isEditing = false
            } else {
                self.editButton.title = "Готово"
                self.tableView.isEditing = true
            }
        }, completion: nil)
    }
    
    private func setupUI() {
            title = "Папки"
            navigationController?.navigationBar.prefersLargeTitles = true
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFolder" {
            guard let editFolderVC = segue.destination as? AddFolderViewController else { return }
            editFolderVC.delegate = self
        } else if segue.identifier == "ShowNotes" {
            guard let notesListVC = segue.destination as? NotesListViewController else { return }
            notesListVC.viewModel = sender as? NotesListViewModelProtocol
            notesListVC.delegate = self
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FoldersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FolderCell", for: indexPath)
        guard let cell = cell as? FolderCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getFolderCellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedFolder = viewModel.getCurrentFolder(at: indexPath)
        let viewModel = NotesListViewModel(notesFolder: selectedFolder)
        performSegue(withIdentifier: "ShowNotes", sender: viewModel)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = viewModel.deleteAction(at: indexPath)
        let rename = viewModel.renameAction(at: indexPath, viewController: self)
        
        let swipe = UISwipeActionsConfiguration(actions: [delete, rename])
        swipe.performsFirstActionWithFullSwipe = false
        return swipe
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    

}

// MARK: - FoldersViewControllerDelegate
extension FoldersViewController: FoldersViewControllerDelegate {
    func reloadTableViewData() {
        viewModel.getNotesFolders()
        tableView.reloadData()
    }
}
