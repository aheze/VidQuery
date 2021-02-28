//
//  ToolbarModifier.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct ToolbarModifier: ViewModifier {
    @Binding var currentView: MediaType

    @Binding var searchFieldText: String
    @Binding var searchResults: [MediaResult]?

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem {
                    TextField("Search...", text: $searchFieldText) { _ in

                    } onCommit: {
                        print("Searching for \"\(searchFieldText)\"...")
                        let api = TMDB_API()
                        api.search(query: searchFieldText, mediaType: currentView) { response in
                            print(response)
                            searchResults = response
                        }
                    }
                    .modifier(TextFieldClearButtonModifier(text: $searchFieldText))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 150)
                    .padding(.leading, 4)
                }
            }
    }
}
