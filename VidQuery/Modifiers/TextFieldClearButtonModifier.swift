//
//  TextFieldClearButtonModifier.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct TextFieldClearButtonModifier: ViewModifier {
    @Binding var text: String

    func body(content: Content) -> some View {
        HStack {
            content

            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                    NSApp.keyWindow?.makeFirstResponder(nil)
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color(.separatorColor))
                }
            }
        }
    }
}
