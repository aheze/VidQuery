//
//  ToolbarModifier.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct ToolbarModifier: ViewModifier {
    @Binding var currentView: MediaType
    
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
                        Label("Anime", systemImage: "tv.music.note")
                            .labelStyle(TitleOnlyLabelStyle())
                            .tag(MediaType.anime)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
    }
}
