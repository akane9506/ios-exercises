//
//  QuoteListView.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/11/25.
//

import SwiftUI

struct QuoteListView: View {
    @Environment(\.modelContext) private var modelContext
    
    let book: Book

    @State private var page = ""
    @State private var text = ""
    @State private var selectedQuote: Quote?
    
    var isEditing: Bool {
        selectedQuote != nil
    }
    
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Page") {
                    TextField("page #", text: $page)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 150)
                    .padding(.leading, 20)
                    Spacer()
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.page = page.isEmpty ? nil : page
                        selectedQuote?.text = text
                        selectedQuote = nil
                    } else {
                        let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
                        book.quotes?.append(quote)
                        text = ""
                        page = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    preview.addExample(books)
    return NavigationStack {
        QuoteListView(book: books[3])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
