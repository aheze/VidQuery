//
//  Containers.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import Foundation
import Cocoa

// MARK: Structures

struct Media: Identifiable {
    let id = UUID()

    let imageName: String
    let title: String
    let description: String = "A show about titans and people killing them."
    let releaseYear: Int
    let mediaType: MediaType
    
    let seasonCount: Int? = nil
    let episodeCount: Int? = nil

    let providers: [Provider] = [
        Provider(name: "9anime", color: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)),
        Provider(name: "Crunchyroll", color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
        Provider(name: "Hulu", color: #colorLiteral(red: 0.1098039216, green: 0.9058823529, blue: 0.5137254902, alpha: 1))
    ]
}

struct Provider: Identifiable {
    let id = UUID()
    var name = "VRV"
    var color: NSColor
    var url = "https://apple.com"
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

// MARK: Enums

enum MediaType {
    case movies
    case tvShows
    case anime
}
