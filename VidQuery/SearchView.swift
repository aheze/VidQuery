//
//  SearchView.swift
//  VidQuery
//
//  Created by Zheng on 2/27/21.
//

import SwiftUI

struct SearchView: View {
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 24)
    ]
    
    @State var selectedResult: TMDBMovieResult?
    @State var mediaView: MediaType = .movies
    @State var waitingForResults = true
    
    @Binding var searchFieldText: String
    @Binding var searchResults: [MediaType : Any]?
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    Text(searchResults == nil ? "Searching..." : "\((searchResults?[.movies] as? [TMDBMovieResult])?.count ?? 0) results")
                        .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                        .font(.system(size: 24, weight: .medium))
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 6, trailing: 0))
                    
                    Spacer()
                    
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
                
                if searchResults == nil {
                    Spacer()
                } else {
                    if let results = searchResults?[.movies] as? [TMDBMovieResult] {
                        
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 24) {
                            ForEach(results) { result in
                                Button(action: {
                                    selectedResult = result
                                }) {
                                    FeaturedCard(imageURL: "https://image.tmdb.org/t/p/w500/" + (result.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg"), title: result.title)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(24)
                        .sheet(item: $selectedResult) { result in
                            DetailView(result: result, dismissNil: $selectedResult)
                        }
                        
                    }
                }
            }
        }
        .frame(minWidth: 350, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchFieldText: .constant(""), searchResults: .constant(nil))
            .previewLayout(.fixed(width: 1000, height: 600))
    }
}
#endif

