//
//  Miniplayer.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/14/21.
//

import SwiftUI
import Kingfisher
import SwiftAudioPlayer

struct Miniplayer: View {
    var animation: Namespace.ID
    @Binding var expand : Bool
    @EnvironmentObject var globalProfile: GlobalProfile
    @EnvironmentObject var authProfile: AuthProfile
    
    var height = UIScreen.main.bounds.height / 3
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets

    @State var volume : CGFloat = 0
    @State var playbackSpeed : CGFloat = 0
    
    @State var playing = true
    @State var playingProgress = 4.0

    @State var offset : CGFloat = 0
    
    @Binding var playingImage : String
    
    var body: some View {
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top,expand ? safeArea?.top : 0)
                .padding(.vertical,expand ? 30 : 0)
            
            HStack(spacing: 15){
                
                // centering IMage...
                
                if expand{Spacer(minLength: 0)}
                if playingImage == "" {
                    let url = URL(string: globalProfile.playingImageURL)!
                    KFImage.url(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: expand ? height : 55, height: expand ? height : 55)
                        .cornerRadius(15)
                } else {
                    let url = URL(string: playingImage)!
                    KFImage.url(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: expand ? height : 55, height: expand ? height : 55)
                        .cornerRadius(15)
                }
                
                if !expand{
                    
                    Text(globalProfile.playingTitle)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                
                Spacer(minLength: 0)
                
                if !expand{
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "play.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "forward.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                    })
                }
            }.onAppear{
                if playingImage == nil {
                    playingImage = globalProfile.playingImageURL
                }
            }.padding(.horizontal)
            
            VStack(spacing: 15){

                Spacer(minLength: 0)
                
                HStack{
                    
                    if expand{
                        
                        Text(globalProfile.playingTitle)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                            .fixedSize(horizontal: false, vertical: true)
                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        
                        Image(systemName: "text.quote")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                .padding(.top,20)
                
                // Live String...
                VStack(){
                    ProgressView(value: playingProgress, total: 9.0)
                      .progressViewStyle(
                        LinearProgressViewStyle(tint: .primary))
                      

                        HStack {
                            Text("00:00").foregroundColor(.primary)

                                Spacer()

                            Text("00:00").foregroundColor(.primary)
                        }.font(.system(size: 14, weight: .semibold))
               
                
                    // Stop Button...
                    
                    HStack {
                        
                        Button {} label: {
                            Image(systemName: "gobackward.15").resizable()
                        }.frame(width: 35, height: 35, alignment: .center).padding().foregroundColor(.primary.opacity(0.6))
                        
                        
                        Button {playing.toggle()} label: {
                            Image(systemName: playing ? "pause.circle.fill" : "play.circle.fill").resizable()
                        }.frame(width: 70, height: 70, alignment: .center).padding().foregroundColor(.primary)
                        
                        
                        Button {} label: {
                            Image(systemName: "goforward.15").resizable()
                        }.frame(width: 35, height: 35, alignment: .center).padding().foregroundColor(.primary.opacity(0.6))
                        
                    }
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "speaker.fill")
                        
                        Slider(value: $volume)
                        
                        Image(systemName: "speaker.wave.2.fill")
                    }.padding()
                    
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "tortoise")
                        
                        Slider(value: $playbackSpeed)
                        
                        Image(systemName: "hare")
                    }
                    
                }.padding()
                
                HStack(spacing: 22){
                    
                    Button(action: {}) {
                        
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {}) {
                        
                        Image(systemName: "airplayaudio")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {}) {
                        
                        Image(systemName: "list.bullet")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom,safeArea?.bottom == 0 ? 0 : safeArea?.bottom)
            }
            // this will give strech effect...
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        // expanding to full screen when clicked...
        .frame(maxHeight: expand ? .infinity : 80)
        // moving the miniplayer above the tabbar...
        // approz tab bar height is 49
        
        // Divider Line For Separting Miniplayer And Tab Bar....
        .background(
        
            VStack(spacing: 0){
                
                FillerView()
//                BlurView()
//
//                Divider()
            }
            .onTapGesture(perform: {
                
                withAnimation(.spring()){expand = true}
            })
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : 10)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .ignoresSafeArea()
    }
    
    func onchanged(value: DragGesture.Value){
        
        // only allowing when its expanded...
        
        if value.translation.height > 0 && expand {
            
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value){
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            
            // if value is > than height / 3 then closing view...
            
            if value.translation.height > height{
                
                expand = false
            }
            
            offset = 0
        }
    }
}
