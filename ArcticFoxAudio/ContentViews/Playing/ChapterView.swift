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
        
        if globalProfile.chaptersTextView == true {
            
            HStack(spacing: 0){
                
                SideTabView()
                
                // Main Content...
                ScrollView(showsIndicators: false, content: {
                    ReadingView()
                })
                           
            }
            
        } else {
            VStack{
                Miniplayer(animation: animation, expand: $expand, playingImage: $playingImage).padding(.top, 1).background(.white)
                Text("Chapters")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,15)
                
                ForEach(0..<playerProfile.chapters_text.count){ i in
                    
                        ZStack(alignment: .bottom){
                            VStack(alignment: .center, content: {
                                        HStack() {
                                            Text("Chapter ")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            
                                            Text(String(i+1))
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.title2)
                                                .foregroundColor(.primary)
                                        }.onAppear{
                                            globalProfile.chapterIndex = globalProfile.chapterIndex+1
                                        }
                            }).onTapGesture {
                                globalProfile.currentTextURL = playerProfile.chapters_text[i] as! String
                                globalProfile.getText(someurl: globalProfile.currentTextURL)
                                globalProfile.chapterIndex = i
                                globalProfile.chaptersTextView.toggle()
                            }
                        }
                    .padding()
                    .frame(height: 50)
                    
                    Spacer()
                }
                
                }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onDisappear{
                    globalProfile.clickedGenre = "For You"
                }
            }
           
        }
}
