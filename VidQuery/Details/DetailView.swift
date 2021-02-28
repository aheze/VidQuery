//
//  DetailView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    let result: MediaResult
    @Binding var dismissNil: MediaResult?
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dismissNil = nil
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .medium))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                HStack(alignment: .top) {
                    KFImage.url(URL(string: "https://image.tmdb.org/t/p/w500/" + (result.type == .movies ? result.movie.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg" : result.tv.posterPath ?? "/nBdoS8tjWubpEyQnqmM6tpZR3GU.jpg")))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .cornerRadius(12)
                        .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
                    
                    VStack(alignment: .leading) {
                        Text(result.type == .movies ? result.movie.title : result.tv.name)
                            .foregroundColor(Color(.secondaryLabelColor))
                            .font(.system(size: 22, weight: .bold))
                            .padding(.bottom, 6)
                        
                        Text(result.type == .movies ? result.movie.overview : result.tv.overview)
                            .foregroundColor(Color(.secondaryLabelColor))
                            .font(.system(size: 19, weight: .regular))
                        
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
                    }
                    .padding(.horizontal, 12)
                    
                    Spacer()
                }
                
//                HStack {
//                    Text("Where to Watch")
//                        .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
//                        .font(.system(size: 24, weight: .medium))
//                        .padding(.top, 16)
//
//                    Spacer()
//                }
//
//                HStack {
//                    Text("Where to Watch")
//                        .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
//                        .font(.system(size: 24, weight: .medium))
//                        .padding(.top, 16)
//
//                    Spacer()
//                }
                
//                ScrollView(.horizontal) {
//                    HStack {
//                        ForEach(media.providers) { provider in
//
//                            Button(action: {
//                                if let url = URL(string: provider.url) {
//                                    NSWorkspace.shared.open(url)
//                                }
//                            }) {
//                                Text(provider.name)
//                                    .foregroundColor(.white)
//                                    .padding(12)
//                                    .background(
//                                        Color(provider.color)
//                                    )
//                                    .cornerRadius(6)
//                                    .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                            .padding(.bottom, 12)
//                        }
//                    }
//                }
                
//                HStack {
//                    Text("Reviews")
//                        .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
//                        .font(.system(size: 24, weight: .medium))
//                        .padding(.top, 16)
//
//                    Spacer()
//                }
                
//                Spacer()
            }
            .padding(24)
        }
        .frame(minWidth: 350, maxWidth: 800, minHeight: 300, maxHeight: .infinity)
    }
}
