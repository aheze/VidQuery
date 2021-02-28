//
//  CategoryCard.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct CategoryCard: View {
    let name: String

    var body: some View {
        
        #if os(macOS)
        HStack {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
            
            Text(name)
                .font(.system(size: 19, weight: .medium))
                .padding(EdgeInsets(top: 12, leading: 2, bottom: 12, trailing: 12))
        }
        .frame(maxWidth: .infinity)
        .background(Color(.textBackgroundColor))
        .cornerRadius(8)
        .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
        
        #else
        HStack {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
            
            Text(name)
                .font(.system(size: 19, weight: .medium))
                .padding(EdgeInsets(top: 12, leading: 2, bottom: 12, trailing: 12))
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
        
        #endif
        
    }
}

#if DEBUG
struct CategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCard(name: "Default")
    }
}
#endif
