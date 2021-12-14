//
//  RecentlyView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/12/21.
//

import SwiftUI

struct RecentlyView: View {
    
    // Miniplayer Properties...
    @State var expand = false
    @Namespace var animation
    
    var body: some View {
        VStack{
            Miniplayer(animation: animation, expand: $expand).padding(.top, 1).background(.white)
            Text("Recently Played")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,30)
                .padding(.leading,15)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2), spacing: 10, content: {

                // Liked Songs...
                ForEach(likedSongs.indices,id: \.self){index in
                    
                    GeometryReader{proxy in
                        
                        Image(likedSongs[index].album_cover)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: proxy.frame(in: .global).width, height: 150)
                            // based on index number were changing the corner style...
                            .clipShape(CustomCorners(corners: index % 2 == 0 ? [.topLeft,.bottomLeft] : [.topRight,.bottomRight], radius: 15))
                    }
                    .frame(height: 150)
                }
            }).padding(.horizontal)
             .padding(.top,20)
        }
    }
}

struct RecentlyView_Previews: PreviewProvider {
    static var previews: some View {
        RecentlyView()
    }
}
