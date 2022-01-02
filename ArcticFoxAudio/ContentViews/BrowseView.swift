//
//  BrowseView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/12/21.
//

import SwiftUI
import Firebase
import Kingfisher

struct BrowseView: View {
    
    @EnvironmentObject var globalProfile: GlobalProfile
    @EnvironmentObject var authProfile: AuthProfile
    @EnvironmentObject var playerProfile: PlayerProfile
    
    // Miniplayer Properties...
    @State var expand = false
    @State var playingImage = ""
    @Namespace var animation
    @State var searchText = ""
    
    var body: some View {
        VStack{
            Miniplayer(animation: animation, expand: $expand, playingImage: $playingImage).padding(.top, 1).background(.white)
            
            HStack(spacing: 15){
                
                HStack(spacing: 15){
                    
                    Circle()
                        .stroke(Color.black,lineWidth: 4)
                        .frame(width: 25, height: 25)
                    
                    TextField("Search...", text: $globalProfile.searchText)
                    
                    Spacer()
                    
                    Button(action: {
                        if globalProfile.searchText != "" {
                            globalProfile.search.toggle()
                        } else {
                            
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.black.opacity(0.06))
                .cornerRadius(8)
                
                Text(authProfile.initials)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("logoColor"))
                    .frame(width:40)
                    .padding(5)
                
            }.padding().onAppear{
                globalProfile.searchText = ""
            }
            
            Text(globalProfile.clickedGenre)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,30)
                .padding(.leading,15)
            
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2), spacing: 10, content: {

                // Liked Songs...
                ForEach(self.globalProfile.searchCard, id: \.self, content: {
                    searchcard in
                    GeometryReader{proxy in
                          SearchArt(searchcard: searchcard).aspectRatio(contentMode: .fill).onTapGesture {
                              if searchcard.title != globalProfile.playingTitle {
                                  playerProfile.unsubscribeFromChanges()
                                  playerProfile.playbackStatus = .ended
                                  //SAPlayer.shared.clear()
                                  globalProfile.playingImageURL = searchcard.coverImage
                                  globalProfile.playingTitle = searchcard.title
                                  playerProfile.chapters_audio = searchcard.chapterAudio
                                  playerProfile.chapters_text = searchcard.chapterText
                                  playerProfile.current_chapter = 0
                                  playerProfile.playClicked()
                                  playerProfile.subscribeToChanges()
                                  playingImage = searchcard.coverImage
                                  expand.toggle()
                              } else {
                                  globalProfile.playingImageURL = searchcard.coverImage
                                  globalProfile.playingTitle = searchcard.title
                                  playerProfile.chapters_audio = searchcard.chapterAudio
                                  playerProfile.chapters_text = searchcard.chapterText
                                  playerProfile.current_chapter = 0
                                  playerProfile.playClicked()
                                  playerProfile.subscribeToChanges()
                                  playingImage = searchcard.coverImage
                                  expand.toggle()
                              }
                          }.frame(width: proxy.frame(in: .global).width, height: 250)
                              // based on index number were changing the corner style...
                            .clipShape(CustomCorners(corners: [.topLeft,.bottomLeft,.topRight,.bottomRight], radius: 15))
                        
                    }.frame(height: 250)
                    
                })
            }).padding(.horizontal)
             .padding(.top,20)
            
        }.navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
         .onDisappear{
             globalProfile.clickedGenre = "For You"
         }
    }
}


