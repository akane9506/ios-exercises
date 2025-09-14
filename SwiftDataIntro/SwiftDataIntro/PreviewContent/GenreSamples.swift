//
//  GenreSamples.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/14/25.
//


import Foundation

extension Genre {
    static var sampleGenres: [Genre] {
        [
            Genre(name: "Friction", color: "00FF00"),
            Genre(name: "Non Friction", color: "0000FF"),
            Genre(name: "Romance", color: "FF0000"),
            Genre(name: "Thriller", color: "000000")
        ]
    }
}
