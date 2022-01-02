//
//  ReadingView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 1/1/22.
//

import SwiftUI

struct ReadingView: View {
    
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
            
            HStack() {
                Text("Chapter \(globalProfile.chapterIndex+1)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,15)
                
                Spacer()
                
                Button(action: {
                    globalProfile.chaptersTextView.toggle()
                }, label: {
                    Text("All Chapters")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width/3)
                        .background(Color("logoColor"))
                        .clipShape(Capsule())
                        .padding()
                })
            }
            
            Text(globalProfile.currentText)
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .opacity(0.9)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(nil)
                .padding(.top,20)
                .padding()
                
            
            
            
        }.onAppear{
            playingImage = globalProfile.playingImageURL
        }.navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
}

struct ReadingView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingView()
    }
}
