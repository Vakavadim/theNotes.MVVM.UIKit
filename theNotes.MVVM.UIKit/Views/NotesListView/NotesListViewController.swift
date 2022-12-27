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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableViewCell()
    }
    
    
    @IBSegueAction func editNote(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> UIViewController? {

    }
    
    @IBSegueAction func openNoteEditorView(_ coder: NSCoder) -> UIViewController? {
        
        return UIHostingController(coder: coder, rootView: NoteEditorView(viewModel: self.viewModel.getNoteEditorViewModelForNewNote()))
        
    }
    
    private func setupUI() {
        title = viewModel.folderName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableViewCell() {
        let nib = UINib(nibName: "NoteCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NoteCell")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
}
