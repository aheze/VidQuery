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
    
    var media = [
        Media(imageName: "sample", title: "Attack on Titan T", releaseYear: 2013, mediaType: .tvShows),
        Media(imageName: "sample", title: "Attack on Titan M", releaseYear: 2013, mediaType: .movies),
        Media(imageName: "sample", title: "Attack on Titan A", releaseYear: 2013, mediaType: .anime),
        Media(imageName: "sample", title: "Attack on Titan M-1", releaseYear: 2013, mediaType: .movies),
        Media(imageName: "sample", title: "Attack on Titan T-1", releaseYear: 2013, mediaType: .tvShows),
        Media(imageName: "sample", title: "Attack on Titan A-1", releaseYear: 2013, mediaType: .anime)
    ]
    
    var categories = [
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
    
    @State var selectedMedia: Media?
    @State var mediaView: MediaType = .movies
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Featured")
                        .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                        .font(.system(size: 24, weight: .medium))
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 6, trailing: 0))
                }
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 24) {
                    ForEach(media) { media in
                        Button(action: {
                            selectedMedia = media
                        }) {
                            FeaturedCard(imageName: "sample", title: media.title)
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
        }
        .frame(minWidth: 350, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .sheet(item: $selectedMedia) { media in
            DetailView(media: media, dismissNil: $selectedMedia)
        }
        .modifier(ToolbarModifier(currentView: $mediaView))
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
