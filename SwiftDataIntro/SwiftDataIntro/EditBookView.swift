//
//  EditBookView.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/7/25.
//

import SwiftUI

struct EditBookView: View {
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var sumamry = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            
        }
    }
}

#Preview {
    EditBookView()
}
