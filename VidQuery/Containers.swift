//
//  Containers.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import Cocoa
import Foundation

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

public struct Genre: Identifiable {
    public let id: Int
    public let name: String
}

// MARK: TMDB Structures

public struct MediaResult: Identifiable {
    public let id = UUID()
    var type = MediaType.movies
    var movie = TMDBMovieResult()
    var tv = TMDBTVResult()
}

struct TMDBMovieResult: Identifiable {
    var id = 0

    var title: String = ""
    var originalTitle: String = ""

    var overview: String = ""

    var adult: Bool = false
    var posterPath: String? = nil
    var releaseDate: String = ""

    var genreIds: [Int] = []

    var popularity: Float = 0
    var voteCount: Int = 0
    var voteAverage: Float = 0
}

struct TMDBTVResult: Identifiable {
    var id = 0

    var name: String = ""
    var originalName: String = ""

    var overview: String = ""

    var posterPath: String?
    var firstAirDate: String = ""
    var originCountry: [String] = []

    var genreIds: [Int] = []

    var popularity: Float = 0
    var voteCount: Int = 0
    var voteAverage: Float = 0
}

// MARK: Enums

public enum MediaType: String {
    case movies = "movie"
    case tvShows = "tv"
}
