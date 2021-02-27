//
//  ContentView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

struct Media: Identifiable {
    let id = UUID()
    
    let title: String
}

struct ContentView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
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
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Featured")
                    .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                    .font(.system(size: 24, weight: .medium))
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    
                    ForEach(media) { media in
                        FeatureCard(image: Image(systemName: "folder"), title: media.title)
                    }
                }
                
            }
            
            
        }
        .navigationTitle("VidQuery")
        .frame(minWidth: 350, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
