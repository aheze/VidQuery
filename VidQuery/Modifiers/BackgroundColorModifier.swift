//
//  BackgroundColorModifier.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            // #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            #if os(macOS)
            content
                .background(
                    Color(.textBackgroundColor)
                        .edgesIgnoringSafeArea(.all)
                )
            #else
            content
                .background(
                    Color(.systemBackground)
                        .edgesIgnoringSafeArea(.all)
                )
            #endif
        }
    }
}
