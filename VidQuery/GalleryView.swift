//
//  GalleryView.swift
//  VidQuery
//
//  Created by Zheng on 2/27/21.
//

import SwiftUI

struct GalleryView: View {
    var genre: Genre
    
    @Binding var dismissNil: Genre?
    @Binding var currentView: MediaType
    
    @State var searchResults: [MediaResult]?
    @State var selectedResult: MediaResult?
    
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 24)
    ]
    
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text(genre.name)
                        .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                        .font(.system(size: 24, weight: .medium))
                        .padding(.bottom, 16)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.6)) {
                            dismissNil = nil
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                    if let results = searchResults {
                        ForEach(results) { result in
                            if result.type == .movies {
                                Button(action: {
                                    selectedResult = result
                                }) {
                                    FeaturedCard(imageURL: "https://image.tmdb.org/t/p/w500/" + (result.movie.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg"), title: result.movie.title)
                                }
                                .buttonStyle(PlainButtonStyle())
                            } else {
                                Button(action: {
                                    selectedResult = result
                                }) {
                                    FeaturedCard(imageURL: "https://image.tmdb.org/t/p/w500/" + (result.tv.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg"), title: result.tv.name)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .sheet(item: $selectedResult) { result in
                    DetailView(result: result, dismissNil: $selectedResult)
                }
            }
            .padding(24)
            
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(.textBackgroundColor)
            
        )
        .onAppear {
            
            let api = TMDB_API()
            api.search(genre: genre, mediaType: currentView) { response in
                print(response)
                searchResults = response
            }
            
        }
    }
}
