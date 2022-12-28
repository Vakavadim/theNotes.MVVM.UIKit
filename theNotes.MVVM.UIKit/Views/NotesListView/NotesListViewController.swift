//
//  NotesListViewController.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 22.12.2022.
//

import SwiftUI

class NotesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NotesListViewModelProtocol!
    weak var delegate: FoldersViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        delegate?.reloadTableViewData()
    }
    
    @IBSegueAction func openNoteEditorView(_ coder: NSCoder) -> UIViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil}
        return UIHostingController(coder: coder, rootView: NoteEditorView(
            viewModel: NoteEditorViewModel(
                noteData: self.viewModel.getNoteData(at: indexPath)
                )
            )
        )
    }
    @IBSegueAction func addNewNote(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: NoteEditorView(
            viewModel: NoteEditorViewModel(
                noteData: self.viewModel.getNoteDataForNewNote()
                )
            )
        )
    }
    
    private func setupUI() {
        title = viewModel.folderName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNotesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        guard let cell = cell as? NoteCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getNoteCellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}
