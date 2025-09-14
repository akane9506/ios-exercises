//
//  RatingsView.swift
//  SwiftDataIntro
//
//  Created by Tingsong Ou on 9/7/25.
//

import SwiftUI

struct RatingsView: View {
    var maxRating: Int
    @Binding var currRating: Int?
    var width: Int
    var color: Color
    var sfSymbol: String
    
    public init(maxRating: Int, currRating: Binding<Int?>, width: Int = 20,
                color: Color = .yellow, sfSymbol: String = "star"
    ) {
        self.maxRating = maxRating
        self._currRating = currRating
        self.width = width
        self.color = color
        self.sfSymbol = sfSymbol
    }
    
    var body: some View {
        HStack {
            Image(systemName: sfSymbol)
                .resizable()
                .scaledToFit()
                .symbolVariant(.slash)
                .foregroundStyle(Color(color))
                .onTapGesture {
                    withAnimation {
                        currRating = nil
                    }
                }
                .opacity(currRating == 0 ? 0 : 1)
            ForEach(1...maxRating, id: \.self) { rating in
                Image(systemName: sfSymbol)
                    .resizable()
                    .scaledToFit()
                    .fillImage(correctImage(for: rating))
                    .foregroundStyle(Color(color))
                    .onTapGesture {
                        withAnimation{
                            currRating = rating
                        }
                    }
            }
        }
        .frame(width: CGFloat(maxRating * width))
    }
    
    // for -> external parameter
    func correctImage(for rating: Int) -> Bool {
        if let currRating, rating <= currRating {
            return true
        } else {
            return false
        }
    }
}

struct FillImage: ViewModifier {
    let fill: Bool
    func body(content: Content) -> some View {
        if fill {
            content.symbolVariant(.fill)
        } else {
            content
        }
    }
}

extension View {
    func fillImage(_ fill: Bool) -> some View {
        modifier(FillImage(fill: fill))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var currRating: Int? = 3
        
        var body: some View {
            RatingsView(
                maxRating: 5, currRating: $currRating, width: 30, color: .red, sfSymbol: "heart"
            )
        }
    }
    
    return PreviewWrapper()
    
}
