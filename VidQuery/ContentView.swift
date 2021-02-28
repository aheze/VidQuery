//
//  ContentView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 24)
    ]

    let categoryColumns = [
        GridItem(.adaptive(minimum: 150), spacing: 24)
    ]

    @State var selectedResult: MediaResult?
    @State var mediaView: MediaType = .movies

//    @State var movies = [TMDBMovieResult]()

    @State var trendingMedia = [MediaResult]()
    @State var genres = [Genre]()

    @State var searchFieldText: String = ""
    @State var searchResults: [MediaResult]?
    
    @State var presentedGenre: Genre?

    var body: some View {
        ZStack {
            if !searchFieldText.isEmpty {
                SearchView(searchFieldText: $searchFieldText, searchResults: $searchResults)
                    .zIndex(0)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Trending")
                                .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                                .font(.system(size: 24, weight: .medium))
                                .padding(.bottom, 16)
                        }

                        LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                            ForEach(trendingMedia) { media in
                                if media.type == .movies {
                                    Button(action: {
                                        selectedResult = media
                                    }) {
                                        FeaturedCard(imageURL: "https://image.tmdb.org/t/p/w500/" + (media.movie.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg"), title: media.movie.title)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                } else {
                                    Button(action: {
                                        selectedResult = media
                                    }) {
                                        FeaturedCard(imageURL: "https://image.tmdb.org/t/p/w500/" + (media.tv.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg"), title: media.tv.name)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }

                        HStack {
                            Text("Categories")
                                .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                                .font(.system(size: 24, weight: .medium))
                                .padding(EdgeInsets(top: 16, leading: 0, bottom: 6, trailing: 0))
                        }

                        LazyVGrid(columns: categoryColumns, alignment: .leading, spacing: 24) {
                            ForEach(genres) { genre in
                                
                                Button(action: {
                                    withAnimation(.easeOut(duration: 0.6)) {
                                        presentedGenre = genre
                                    }
                                }) {
                                    CategoryCard(name: genre.name)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        
                    }
                    .padding(24)
                    .sheet(item: $selectedResult) { result in
                        DetailView(result: result, dismissNil: $selectedResult)
                    }
                }
                .zIndex(1)
                .onAppear(perform: {
                    let api = TMDB_API()
                    api.getGenres { tmdbGenres in
                        genres = tmdbGenres
                    }
                    api.getTrending(mediaType: mediaView) { trending in
                        trendingMedia = trending
                    }
                })
            }
            
            if let presentedGenre = presentedGenre {
                GalleryView(genre: presentedGenre, dismissNil: $presentedGenre, currentView: $mediaView)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.move(edge: .top))
                    .zIndex(2)
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
