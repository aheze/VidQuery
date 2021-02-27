//
//  FeatureCard.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

struct FeatureCard: View {
    var image: Image?
    var title: String = ""
    
    var body: some View {
        VStack {
            image
            
            Text(title)
            
        }
        .background(
            Color.white
        )
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard()
    }
}
