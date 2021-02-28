//
//  Containers.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

#if os(macOS)
import Cocoa
#else
import UIKit
#endif
import Foundation

// MARK: Structures

struct Contributor: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let role: ContributorRole
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

enum Appearance: String, Identifiable {
    case system
    case light
    case dark

    var id: String { self.rawValue }
}

enum ContributorRole: String {
    case developer = "Development Team"
    case graphics = "Graphic Team"
}
