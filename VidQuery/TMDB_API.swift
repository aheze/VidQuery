//
//  TMDB_API.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//
import Foundation
import SwiftyJSON

public class TMDB_API {
    private let readToken: String = "TMDB_READ_TOKEN"
    

    let baseUrl = URL(string: "https://api.themoviedb.org")
    
    public init() {}
    
    public func search(query: String? = nil, genre: Genre? = nil, mediaType: MediaType, completionHandler: @escaping (([MediaResult]) -> Void)) {
        var searchUrl: URL?
        
        var genreSearch = false
        
        if let genre = genre {
            genreSearch = true
            searchUrl = URL(string: "3/discover/movie?with_genres=\(genre.id)", relativeTo: baseUrl)!
        } else if let query = query {
            genreSearch = false
            searchUrl = URL(string: "3/search/multi?query=\(query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? query)", relativeTo: baseUrl)!
        }
        
        guard let searchUrlUnwrapped = searchUrl else { return }
        
        performRequest(url: searchUrlUnwrapped) { data in
            var results = [MediaResult]()
            
            do {
                let json = try JSON(data: data)
                
                json["results"].forEach { _, value in
                    var result = MediaResult()
                    let genreIds = value["genre_ids"].arrayValue.map { $0.intValue }
                    
                    if genreSearch == true {
                        result.type = .movies
                        result.movie = TMDBMovieResult(id: value["id"].intValue, title: value["title"].stringValue, originalTitle: value["original_title"].stringValue, overview: value["overview"].stringValue, adult: value["adult"].boolValue, posterPath: value["poster_path"].stringValue, releaseDate: value["release_date"].stringValue, genreIds: genreIds, popularity: value["popularity"].floatValue, voteCount: value["vote_count"].intValue, voteAverage: value["vote_average"].floatValue)
                    } else {
                        if value["media_type"] == "movie" {
                            let genreIds = value["genre_ids"].arrayValue.map { $0.intValue }
                            
                            result.type = .movies
                            result.movie = TMDBMovieResult(id: value["id"].intValue, title: value["title"].stringValue, originalTitle: value["original_title"].stringValue, overview: value["overview"].stringValue, adult: value["adult"].boolValue, posterPath: value["poster_path"].stringValue, releaseDate: value["release_date"].stringValue, genreIds: genreIds, popularity: value["popularity"].floatValue, voteCount: value["vote_count"].intValue, voteAverage: value["vote_average"].floatValue)
                            
                        } else if value["media_type"] == "tv" {
                            let genreIds = value["genre_ids"].arrayValue.map { $0.intValue }
                            let originCountry = value["origin_country"].arrayValue.map { $0.stringValue }
                            
                            result.type = .tvShows
                            result.tv = TMDBTVResult(id: value["id"].intValue, name: value["name"].stringValue, originalName: value["original_name"].stringValue, overview: value["overview"].stringValue, posterPath: value["poster_path"].stringValue, firstAirDate: value["first_air_date"].stringValue, originCountry: originCountry, genreIds: genreIds, popularity: value["popularity"].floatValue, voteCount: value["vote_count"].intValue, voteAverage: value["vote_average"].floatValue)
                        }
                    }
                    
                    results.append(result)
                }
                
                completionHandler(results)
            } catch {
                print("[JSON Error] \(error.localizedDescription)")
            }
        }
    }
    
    public func getGenres(completionHandler: @escaping (([Genre]) -> Void)) {
        let genresUrl = URL(string: "3/genre/movie/list?language=en-US", relativeTo: baseUrl)!
        
        performRequest(url: genresUrl) { data in
            var genres: [Genre] = []
            
            do {
                let json = try JSON(data: data)
                json["genres"].forEach { _, genre in
                    genres.append(Genre(id: genre["id"].intValue, name: genre["name"].stringValue))
                }
                
                completionHandler(genres)
            } catch {
                print("[JSON Error] \(error.localizedDescription)")
            }
        }
    }
    
    public func getByGenre() {}
    
    public func getTrending(mediaType: MediaType, completionHandler: @escaping (([MediaResult]) -> Void)) {
        let trendingUrl = URL(string: "3/trending/\(mediaType)/day", relativeTo: baseUrl)!
        
        performRequest(url: trendingUrl) { data in
            var trending: [MediaResult] = []
            
            do {
                let json = try JSON(data: data)
                
                json["results"].forEach { _, value in
                    var result = MediaResult()
                    let genreIds = value["genre_ids"].arrayValue.map { $0.intValue }
                    
                    if value["media_type"] == "movie" {
                        result.type = .movies
                        result.movie = TMDBMovieResult(id: value["id"].intValue, title: value["title"].stringValue, originalTitle: value["original_title"].stringValue, overview: value["overview"].stringValue, adult: value["adult"].boolValue, posterPath: value["poster_path"].stringValue, releaseDate: value["release_date"].stringValue, genreIds: genreIds, popularity: value["popularity"].floatValue, voteCount: value["vote_count"].intValue, voteAverage: value["vote_average"].floatValue)
                        
                    } else if value["media_type"] == "tv" {
                        let originCountry = value["origin_country"].arrayValue.map { $0.stringValue }
                        
                        result.type = .tvShows
                        result.tv = TMDBTVResult(id: value["id"].intValue, name: value["name"].stringValue, originalName: value["original_name"].stringValue, overview: value["overview"].stringValue, posterPath: value["poster_path"].stringValue, firstAirDate: value["first_air_date"].stringValue, originCountry: originCountry, genreIds: genreIds, popularity: value["popularity"].floatValue, voteCount: value["vote_count"].intValue, voteAverage: value["vote_average"].floatValue)
                    }
                    
                    trending.append(result)
                }
                
                completionHandler(trending)
            } catch {
                print("[JSON Error] \(error.localizedDescription)")
            }
        }
    }
    
    private func performRequest(url: URL, completionHandler: @escaping (Data) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(readToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("utf-8", forHTTPHeaderField: "charset")
        
        let task = session.dataTask(with: request) { data, _, error in
            if error == nil {
                if let data = data {
                    completionHandler(data)
                }
            } else {
                // TODO: Add no read token error handling
                print("Error: \(String(describing: error))")
            }
        }
        
        task.resume()
    }
}
