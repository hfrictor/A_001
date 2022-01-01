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
                
                GeometryReader{proxy in
                    
                    VStack(alignment: .center){
                        
                        ChapterArt(chaptercard: chaptercard).aspectRatio(contentMode: .fill).onTapGesture {
                           
                            }.frame(width: proxy.frame(in: .global).width)
                             .cornerRadius(20)
                        Spacer()
                    }
                }
                .padding()
                .frame(height: 20)
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
        ZStack(alignment: .bottom, content: {
            Button(action: {
                
            }, label: {
                VStack() {
                    Divider().background(Color.primary)
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
                    }.padding()
                    Divider().background(Color.primary)
                }
            })
        })
    }
    
}

