//
//  BookListItem.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/7/25.
//

import SwiftUI

struct BookListLabel: View {
    let book:Book
    
    var body: some View {
        HStack(spacing: 10) {
            book.icon
            VStack(alignment: .leading) {
                Text(book.title).font(.title2)
                Text(book.author).foregroundStyle(.secondary)
                if let rating = book.rating {
                    HStack {
                        ForEach(0 ..< rating, id:\.self) { _ in
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundStyle(.yellow)
                        }
                    }
                    .padding(.top, 0.2)
                }
            }
        }
    }
}

#Preview {
    BookListLabel(book: Book(title: "Elephant", author: "Harrod", rating: 3))
}
