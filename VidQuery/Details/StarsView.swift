//
//  StarsView.swift
//  VidQuery
//
//  Created by Zheng on 2/27/21.
//

import SwiftUI

/// From https://stackoverflow.com/a/64389917/14351818
struct StarsView: View {
    var rating: CGFloat
    var maxRating: Int

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0 ..< maxRating) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing, 2)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.7930627822, blue: 0.001607940936, alpha: 1)))
                }
            }
            .mask(stars)
        )
        .foregroundColor(Color(.lightGray))
    }
}
