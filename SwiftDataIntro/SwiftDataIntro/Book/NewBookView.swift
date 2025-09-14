//
//  NewBookView.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/6/25.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @State private var title: String = ""
    @State private var author: String = ""
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("BookTitle", text:$title)
                    TextField("Author", text:$author)
                }
                Section {
                    Button("Create") {
                        let newBook = Book(title: title, author: author)
                        context.insert(newBook)
                        dismiss()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.plain)
                    .disabled(title.isEmpty || author.isEmpty)
                    .foregroundColor(.accentColor)
                }
                .padding(0)
            }
            .formStyle(.grouped)
            .navigationTitle("New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewBookView()
}
