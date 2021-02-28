//
//  ContentView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

let media = [
    Media(imageName: "sample", title: "Attack on Titan T", releaseYear: 2013, mediaType: .tvShows),
    Media(imageName: "sample", title: "Attack on Titan M", releaseYear: 2013, mediaType: .movies),
    Media(imageName: "sample", title: "Attack on Titan M-1", releaseYear: 2013, mediaType: .movies),
    Media(imageName: "sample", title: "Attack on Titan T-1", releaseYear: 2013, mediaType: .tvShows)
]

let categories = [
    Category(name: "Gaming"),
    Category(name: "Tech"),
    Category(name: "Cartoons"),
    Category(name: "Comedy"),
    Category(name: "Slice of life"),
    Category(name: "Action"),
    Category(name: "Gaming"),
    Category(name: "Tech"),
    Category(name: "Cartoons"),
    Category(name: "Comedy"),
    Category(name: "Slice of life"),
    Category(name: "Action"),
    Category(name: "Horror")
]

struct ContentView: View {
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 24)
    ]
    
    let categoryColumns = [
        GridItem(.adaptive(minimum: 150), spacing: 24)
    ]
    
    @State var selectedResult: TMDBMovieResult?
    @State var mediaView: MediaType = .movies
    
    @State var movies = [TMDBMovieResult]()
    
    @State var searchFieldText: String = ""
    @State var searchResults: [MediaType : Any]?
    
    var body: some View {
        Group {
            if !searchFieldText.isEmpty {
                SearchView(searchFieldText: $searchFieldText, searchResults: $searchResults)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Trending")
                                .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                                .font(.system(size: 24, weight: .medium))
                                .padding(EdgeInsets(top: 16, leading: 0, bottom: 6, trailing: 0))
                        }
                        
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 24) {
                            ForEach(movies) { movie in
                                Button(action: {
                                    selectedResult = movie
                                }) {
                                    FeaturedCard(imageURL: "https://image.tmdb.org/t/p/w500/" + (movie.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg"), title: movie.title)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                        HStack {
                            Text("Categories")
                                .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                                .font(.system(size: 24, weight: .medium))
                                .padding(EdgeInsets(top: 16, leading: 0, bottom: 6, trailing: 0))
                        }
                        
                        LazyVGrid(columns: categoryColumns, alignment: .leading, spacing: 24) {
                            ForEach(categories) { category in
                                CategoryCard(name: category.name)
                            }
                        }
                    }
                    .padding(24)
                    .sheet(item: $selectedResult) { result in
                        DetailView(result: result, dismissNil: $selectedResult)
                    }
                }
                .onAppear {
                    let api = TMDB_API()
                    api.getTrending { results in
                        if let movieResults = results[.movies] as? [TMDBMovieResult] {
                            movies = Array(movieResults.prefix(10))
                        }
                    }
                    
                }
            }
        }
        .frame(minWidth: 350, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .modifier(ToolbarModifier(currentView: $mediaView, searchFieldText: $searchFieldText, searchResults: $searchResults))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 600))
    }
}
#endif
