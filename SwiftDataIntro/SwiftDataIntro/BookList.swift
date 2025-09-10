//
//  BookList.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/8/25.
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    init(sortOrder:SortOrder, filterString:String) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .author:
            [SortDescriptor(\Book.author)]
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.title)]
        }
        
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterString) ||
            book.author.localizedStandardContains(filterString) ||
            filterString.isEmpty
        }
        
        _books = Query(filter: predicate, sort: sortDescriptors)
    }
    var body: some View {
        Group{
            if books.isEmpty {
                ContentUnavailableView("Enter your first book.", systemImage: "book.fill")
            }
            else {
                List {
                    ForEach(books) { book in
                        NavigationLink{
                            EditBookView(book: book)
                        } label: {
                            BookListLabel(book: book)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let book = books[index]
                            context.delete(book)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExample(Book.sampleBooks)
    return NavigationStack {
        BookList(sortOrder: .author, filterString: "")
            .modelContainer(preview.container)
    }
}
