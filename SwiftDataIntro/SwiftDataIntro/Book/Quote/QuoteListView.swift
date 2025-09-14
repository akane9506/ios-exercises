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
                        .textFieldStyle(.plain)
                        .padding(.leading, 4)
                        .frame( height: 30)
                        .background(Color(.white))
                        .cornerRadius(8)
                        .padding(.leading, 20)
                    Spacer()
                    if isEditing {
                        Button("Cancel") {
                            page = ""
                            text = ""
                            selectedQuote = nil
                        }
                        .buttonStyle(.bordered)
                    }
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedQuote?.page = page.isEmpty ? nil : page
                        selectedQuote?.text = text
                        page = ""
                        text = ""
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
            TextEditor(text: $text)
                .frame(height: 100)
                .cornerRadius(8)
        }
        .padding(.horizontal)
        
        List{
            let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
            ForEach(sortedQuotes) { quote in
                VStack(alignment: .leading) {
                    Text(quote.creationDate, format: .dateTime.month().day().year())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(quote.text)
                    HStack {
                        Spacer()
                        if let page = quote.page, !page.isEmpty {
                            Text("Page: \(page)")
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedQuote = quote
                    text = quote.text
                    page = quote.page ?? ""
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        let quote = sortedQuotes[index]
                        book.quotes?.forEach{ bookQuote in
                            if quote.id == bookQuote.id {
                                modelContext.delete(quote)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Quotes")
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
