//
//  Quote.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/11/25.
//

import Foundation
import SwiftData

@Model
class Quote {
    var creationDate: Date = Date.now
    var text: String
    var page: String?
    var book: Book?
    
    init (text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
}
