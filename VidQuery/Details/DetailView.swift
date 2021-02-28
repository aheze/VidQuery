//
//  DetailView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import Kingfisher
import SwiftUI

struct DetailView: View {
    let result: MediaResult
    @Binding var dismissNil: MediaResult?
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    KFImage.url(URL(string: "https://image.tmdb.org/t/p/w500/" + (result.type == .movies ? result.movie.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg" : result.tv.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg")))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .cornerRadius(12)
                        .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text("\(result.type == .movies ? result.movie.title : result.tv.name) (\((result.type == .movies ? result.movie.releaseDate : result.tv.firstAirDate).components(separatedBy: "-")[0]))")
                                .foregroundColor(Color(.secondaryLabelColor))
                                .font(.system(size: 22, weight: .bold))
                                .padding(.bottom, 3)
                        
                            Spacer()
                        
                            Button(action: {
                                dismissNil = nil
                            }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 18, weight: .medium))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.bottom, 8)
                        
                        Text(result.type == .movies ? result.movie.overview : result.tv.overview)
                            .foregroundColor(Color(.secondaryLabelColor))
                            .font(.system(size: 16, weight: .regular))
                            .padding(.bottom, 8)
                        
                        StarsView(rating: CGFloat(result.type == .movies ? result.movie.voteAverage : result.tv.voteAverage), maxRating: 10)
                            .frame(height: 16)
                        
                        HStack {
                            Text("\(result.type == .movies ? result.movie.voteCount : result.tv.voteCount) votes")
                                .foregroundColor(Color(.secondaryLabelColor))
                                .font(.system(size: 15, weight: .regular))
                            
                            Circle()
                                .fill(
                                    Color(.secondaryLabelColor)
                                )
                                .frame(width: 4, height: 4)
                            
                            Text("\(String(format: "%.1f", result.type == .movies ? result.movie.voteAverage : result.tv.voteAverage))/10")
                                .foregroundColor(Color(.secondaryLabelColor))
                                .font(.system(size: 15, weight: .regular))
                            
                            Spacer()
                        }
                        .padding(.bottom, 8)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                if let url = URL(string: "https://www.themoviedb.org/\(result.type.rawValue)/\(result.type == .movies ? result.movie.id : result.tv.id)") {
                                    NSWorkspace.shared.open(url)
                                }
                            }) {
                                Text("Open on TheMovieDb")
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color("tmdbBackgroundColor"))
                            .foregroundColor(Color("tmdbForegroundColor"))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 12)
                }
            }
            .padding(24)
        }
        .frame(minWidth: 350, maxWidth: 1000, minHeight: 275, maxHeight: 600)
    }
}
