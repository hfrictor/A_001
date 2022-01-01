//
//  ChapterView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Kingfisher

struct ChapterView: View {
    
    @EnvironmentObject var globalProfile: GlobalProfile
    @EnvironmentObject var authProfile: AuthProfile
    @EnvironmentObject var playerProfile: PlayerProfile
    
    // Miniplayer Properties...
    @State var expand = false
    @State var playingImage = ""
    @Namespace var animation
    
    var body: some View {
        VStack{
            Miniplayer(animation: animation, expand: $expand, playingImage: $playingImage).padding(.top, 1).background(.white)
            Text("Chapters screen")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,30)
                .padding(.leading,15)
            
            ForEach(self.globalProfile.chapterCard, id: \.self, content: {
                chaptercard in
                    
                    ZStack(alignment: .bottom){
                        
                        ChapterArt(chaptercard: chaptercard).aspectRatio(contentMode: .fill).onTapGesture {
                           
                        }
                    }
                .padding()
                .frame(height: 50)
                
                Spacer()
            })
            
            }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onDisappear{
                globalProfile.clickedGenre = "For You"
            }
            
           
        }
}
    


struct ChapterArt: View {
    var chaptercard : ChapterCard
    var body: some View {
        VStack(alignment: .center, content: {
            Button(action: {
                
            }, label: {
                VStack() {
                    HStack() {
                        Text("Chapter ")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text(String(chaptercard.title))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
            })
        })
    }
    
}

