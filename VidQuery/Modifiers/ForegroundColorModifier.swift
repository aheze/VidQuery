//
//  ForegroundColorModifier.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct ForegroundColorModifier: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            #if os(macOS)
            content
                .foregroundColor(Color(.secondaryLabelColor))
            #else
            content
                .foregroundColor(Color(.secondaryLabel))
            #endif
        }
    }
}
