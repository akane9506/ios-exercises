//
//  SwiftDataIntroApp.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/6/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataIntroApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Book.self])
        let config = ModelConfiguration("MyBooks", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        //        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        } catch {
//            fatalError()
//        }
//        print(URL.documentsDirectory.path())
        
    }
}
