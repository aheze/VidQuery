//
//  DetailView.swift
//  VidQuery
//
//  Created by Zheng on 2/26/21.
//

import SwiftUI

struct DetailView: View {
    
    var media: Media = Media(imageName: "sample", title: "Attack on Titan")
    @Binding var dismissNil: Media?
    
    var body: some View {
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
                Image(media.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .cornerRadius(12)
                    .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
                    
                
                VStack(alignment: .leading) {
                    Text(media.title)
                        .foregroundColor(Color(.secondaryLabelColor))
                        .font(.system(size: 22, weight: .bold))
                        .padding(.bottom, 6)
                    
                    Text(media.description)
                        .foregroundColor(Color(.secondaryLabelColor))
                        .font(.system(size: 19, weight: .regular))
                    
                }
                .padding(.horizontal, 12)
                
                Spacer()
            }
            
            HStack {
                Text("Where to watch")
                    .foregroundColor(Color(#colorLiteral(red: 0.6621153355, green: 0.6622314453, blue: 0.6621080041, alpha: 1)))
                    .font(.system(size: 24, weight: .medium))
                    .padding(.top, 16)
                
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(media.providers) { provider in
                        
                        Button(action: {
                            if let url = URL(string: provider.url) {
                                NSWorkspace.shared.open(url)
                            }
                        }) {
                            Text(provider.name)
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    Color(provider.color)
                                )
                                .cornerRadius(6)
                                .shadow(color: Color(#colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 0.5)), radius: 5, x: 0.0, y: 2)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.bottom, 12)
                    }
                }
                
            }
            
            Spacer()
        }
        .padding(24)
        .frame(minWidth: 350, maxWidth: 800, minHeight: 300, maxHeight: .infinity)
    }
}

#if DEBUG
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//            .previewLayout(.fixed(width: 600, height: 600))
//    }
//}
#endif
