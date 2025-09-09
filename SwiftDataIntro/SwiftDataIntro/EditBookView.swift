//
//  EditBookView.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/7/25.
//

import SwiftUI

struct EditBookView: View {
    let book: Book
    @State private var tempBook = Book(title: "", author: "", summary: "", status: Status.onShelf)
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $tempBook.status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $tempBook.dateAdded, displayedComponents: .date)
                } label : {
                    Text("Date Added")
                }
                if tempBook.status == .completed || tempBook.status == .inProgress {
                    LabeledContent {
                        DatePicker("", selection: $tempBook.dateStarted, in: tempBook.dateAdded..., displayedComponents: .date)
                    } label : {
                        Text("Date Started")
                    }
                }
                if tempBook.status == .completed {
                    LabeledContent {
                        DatePicker("", selection: $tempBook.dateCompleted, in: tempBook.dateStarted..., displayedComponents: .date)
                    } label : {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            
            Divider()
            LabeledContent {
                TextField("", text:$tempBook.title)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
            
            LabeledContent {
                TextField("", text:$tempBook.author)
            } label: {
                Text("Author").foregroundStyle(.secondary)
            }
            
            LabeledContent {
                RatingsView(maxRating: 5, currRating: $tempBook.rating, width: 25)
            } label: {
                Text("Rating").foregroundStyle(.secondary)
            }
            
            Divider()
            
            Text("Summary").foregroundStyle(.secondary)
            TextEditor(text: $tempBook.summary)
                .padding(
                    5
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            Color.secondary.opacity(0.3),
                        lineWidth: 1
                    )
                )
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(tempBook.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    book.status = tempBook.status
                    book.rating = tempBook.rating
                    book.title = tempBook.title
                    book.author = tempBook.author
                    book.summary = tempBook.summary
                    book.dateAdded = tempBook.dateAdded
                    book.dateStarted = tempBook.dateStarted
                    book.dateCompleted = tempBook.dateCompleted
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            tempBook.status = book.status
            tempBook.rating = book.rating
            tempBook.title = book.title
            tempBook.author = book.author
            tempBook.summary = book.summary
            tempBook.dateAdded = book.dateAdded
            tempBook.dateStarted = book.dateStarted
            tempBook.dateCompleted = book.dateCompleted
        }
    }
    
    var changed: Bool {
        tempBook != book
    }
    
}

#Preview {
    let preview = Preview(Book.self)
    return NavigationStack {
        EditBookView(book: Book.sampleBooks[4])
            .modelContainer(preview.container)
    }
}
