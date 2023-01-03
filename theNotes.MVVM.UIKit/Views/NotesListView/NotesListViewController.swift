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
    
    private var hostingView: UIHostingController<NoteEditorView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("dismissSwiftUI"), object: nil, queue: nil) { (_) in
            self.hostingView!.dismiss(animated: true, completion: nil)
            print("dismissSwiftUI")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        delegate?.reloadTableViewData()
    }
    
    @IBSegueAction func openNoteEditorView(_ coder: NSCoder) -> UIViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil}
        let noteEditorViewModel = NoteEditorViewModel(noteData: self.viewModel.getNoteData(at: indexPath))
        let noteEditorView = NoteEditorView(
            viewModel: noteEditorViewModel
            )
        let hostingView = UIHostingController(coder: coder, rootView: noteEditorView)
        self.hostingView = hostingView
        return hostingView
    }
    @IBSegueAction func addNewNote(_ coder: NSCoder) -> UIViewController? {
        let noteEditorViewModel = NoteEditorViewModel(noteData: self.viewModel.getNoteDataForNewNote())
        let noteEditorView = NoteEditorView(
            viewModel: noteEditorViewModel
            )
        let hostingView = UIHostingController(coder: coder, rootView: noteEditorView)
        self.hostingView = hostingView
        return hostingView
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
