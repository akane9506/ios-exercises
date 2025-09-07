//
//  Book.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/6/25.
//

import Foundation

class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var summary: String
    var rating: Int?
    var status: Status
    
    init(
        title: String,
        author: String,
        dateAdded: Date,
        dateStarted: Date,
        status: Status,
        summary: String,
        rating: Int? = nil
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.summary = summary
        self.status = status
        self.rating = rating
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
