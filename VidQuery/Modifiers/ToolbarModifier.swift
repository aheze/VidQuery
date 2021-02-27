//
//  ToolbarModifier.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct ToolbarModifier: ViewModifier {
    @Binding var currentView: MediaType
    @State var searchField: String = ""

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem {
                    Picker(selection: $currentView, label: Text("View")) {
                        Label("Movies", systemImage: "film")
                            .labelStyle(TitleOnlyLabelStyle())
                            .tag(MediaType.movies)
                        Label("TV Shows", systemImage: "tv")
                            .labelStyle(TitleOnlyLabelStyle())
                            .tag(MediaType.tvShows)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                ToolbarItem {
                    TextField("Search...", text: $searchField, onCommit: {
                        print("Searching for \"\(searchField)\"...")
                        let api = TMDB_API()
                        api.search(query: searchField, mediaType: currentView) { response in
                            print(response)
                        }
                        print("Completion handler?")
                    })
                        .modifier(TextFieldClearButtonModifier(text: $searchField))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minWidth: 150)
                        .padding(.leading, 4)
                }
            }
    }
}
