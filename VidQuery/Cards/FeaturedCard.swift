//
//  FeaturedCard.swift
//  VidQuery
//
//  Created by H. Kamran on 2/27/21.
//

import SwiftUI

struct FeaturedCard: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color(.secondaryLabelColor))
                .padding(EdgeInsets(top: 2, leading: 6, bottom: 6, trailing: 6))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        
        .background(Color(.textBackgroundColor))
        .cornerRadius(8)
        .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
       
    }
}

#if DEBUG
struct FeaturedCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCard(imageName: "sample", title: "Attack on Titan")
    }
}
#endif
