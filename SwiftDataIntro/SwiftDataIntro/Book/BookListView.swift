//
//  ContentView.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/6/25.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, author
    var id: Self {
        self
    }
}

struct BookListView: View {
    @State private var createNewBook: Bool = false
    @State private var sortOrder: SortOrder = .title
    @State private var filterString: String = ""
    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)
            BookList(sortOrder: sortOrder, filterString: filterString)
                .searchable(text: $filterString, prompt: "Filter on title or author")
                .toolbar {
                    Button {
                        // action
                        createNewBook = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                .navigationTitle("My Books")
            
                .sheet(isPresented: $createNewBook) {
                    NewBookView()
                        .presentationDetents([.medium])
                }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExample(Book.sampleBooks)
    preview.addExample(Genre.sampleGenres)
    return BookListView()
        .modelContainer(preview.container)
}
