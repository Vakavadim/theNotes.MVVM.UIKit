//
//  NoteEditorView.swift
//  theNotes.MVVM.UIKit
//
//  Created by Вадим Гамзаев on 27.12.2022.
//

import RichTextKit
import SwiftUI

struct NoteEditorView: View {
    
    @StateObject var viewModel: NoteEditorViewModel
    @StateObject var context = RichTextContext()
    
    @State var buttonTitile = "Сохранить"

    var body: some View {
        VStack {
            noteTitieTextField.padding(.horizontal, 8)
            editor
                .padding(8)
            toolbar
        }
        .background(Color.primary.opacity(0.15))
        .navigationTitle(viewModel.folderName)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(buttonTitile, action: doneAction)
            }
        }
        .viewDebug()
    }
    
    private func doneAction() {
        viewModel.saveNote()
        NotificationCenter.default.post(name: NSNotification.Name("dismissSwiftUI"), object: nil)
    }

}

private extension NoteEditorView {
    var editor: some View {
        RichTextEditor(text: $viewModel.noteText, context: context) {
            $0.textContentInset = CGSize(width: 10, height: 20)
        }
        .background(Color(.white))
        .cornerRadius(5)
        .focusedValue(\.richTextContext, context)
    }

    var toolbar: some View {
        RichTextKeyboardToolbar(
            context: context,
            leadingButtons: {},
            trailingButtons: {}
        )
    }
    
    var noteTitieTextField: some View {
        ZStack{
            Color(.white)
            TextField("", text: $viewModel.noteTitle)
                .fontWeight(.medium)
                .offset(CGSize(width: 16, height: 0))
        }
        .frame(height: 44)
        .border(.white, width: 1)
        .cornerRadius(5)
    }
}
