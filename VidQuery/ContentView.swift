//
//  ContentView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

struct Media: Identifiable {
    let id = UUID()
    
    var imageName: String = "sample"
    let title: String
    let description: String = "A show about titans and people killing them. Asdlkj sldkfjs dlfjslkdfj dslfjklsdjflds fkldsjfklds flksdjflkjsdf lsdjfl lskdjflksdf lsdjflsdfldssldkf"
    var providers = [
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

struct Category: Identifiable {
    let id = UUID()
    
    let name: String
}

struct ContentView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 24)
    ]
    
    let categoryColumns = [
        GridItem(.adaptive(minimum: 150), spacing: 24)
    ]
    
    var media = [
        Media(title: "Attack on Titan"),
        Media(title: "sdfsdfsdf"),
        Media(title: "sdf"),
        Media(title: "sdfsdfdfsdf"),
        Media(title: "sdfsd"),
        Media(title: "sdf"),
        Media(title: "sdfsdfsdfsdf")
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
                            FeatureCard(title: media.title)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 1000, height: 600))
            
    }
}
