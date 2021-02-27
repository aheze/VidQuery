//
//  Cards.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

struct FeatureCard: View {
    var image: Image = Image("sample")
    var title: String = "Title"
    
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color(.secondaryLabelColor))
                .padding(EdgeInsets(top: 2, leading: 6, bottom: 6, trailing: 6))
            
        }
        .background(
            Color(.textBackgroundColor)
        )
        .cornerRadius(8) .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
    }
}

struct CategoryCard: View {
    var name: String = "Title"
    
    var body: some View {
        VStack {
            
            Text(name)
                .font(.system(size: 19, weight: .medium))
                .padding(12)
            
        }
        .frame(maxWidth: .infinity)
        .background(
            Color(.textBackgroundColor)
        )
        .cornerRadius(8) .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard()
    }
}


struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard()
    }
}
