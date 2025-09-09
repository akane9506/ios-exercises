//
//  Book.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/6/25.
//

import SwiftUI
import SwiftData

@Model
class Book: Equatable {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var summary: String
    var rating: Int?
    var status: Status

    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        summary: String = "",
        rating: Int? = nil,
        status: Status = .onShelf
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    
    var icon: Image {
        switch status {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            Image(systemName: "book.fill")
        case .completed:
            Image(systemName: "books.vertical.fill")
        }
    }
    
    static func  ==(lhs: Book, rhs: Book) -> Bool {
        lhs.title == rhs.title &&
        lhs.author == rhs.author &&
        lhs.summary == rhs.summary &&
        lhs.status == rhs.status &&
        lhs.rating == rhs.rating &&
        lhs.dateAdded == rhs.dateAdded &&
        lhs.dateStarted == rhs.dateStarted &&
        lhs.dateCompleted == rhs.dateCompleted
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    
    var id: Self {
        self
    }
    
    var descr: String {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
