//
//  SearchView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/14/21.
//

import SwiftUI

struct SearchView: View {
    
    // Search Text...
    @State var searchText = ""
    
    // Miniplayer Properties...
    @State var expand = false
    @Namespace var animation
    
    var body: some View {
        VStack{
            
            Spacer()
            
            
            Miniplayer(animation: animation, expand: $expand).padding(.top, 1).background(.white)
            
            HStack(spacing: 15){
                
                HStack(spacing: 15){
                    
                    Circle()
                        .stroke(Color.black,lineWidth: 4)
                        .frame(width: 25, height: 25)
                    
                    TextField("Search...", text: $searchText)
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.black.opacity(0.06))
                .cornerRadius(8)
                
                Text("HF")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("logoColor"))
                    .frame(width:45)
                    .padding(5)
                
            }
            
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
        }.navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
