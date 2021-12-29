//
//  HomeView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Kingfisher
import Firebase

let globalProfile = GlobalProfile()
let emailSaved = UserDefaults.standard.string(forKey: "Email") ?? ""

struct HomeCard : Hashable {
    var id = UUID()
    var title : String
    var author : String
    var description : String
    var pubDate : String
    var coverImage : String
    var afhCode : String
}

struct RecentCard : Hashable {
    var id = UUID()
    var title : String
    var author : String
    var description : String
    var pubDate : String
    var coverImage : String
    var afhCode : String
}


struct HomeView: View {
    
    // Search Text...
    @State var searchText = ""
    @State var search = false
    @EnvironmentObject var globalProfile: GlobalProfile
    @EnvironmentObject var authProfile: AuthProfile
    @EnvironmentObject var playerProfile: PlayerProfile
    @State var initials = ""
    
    @State var accountViewing = false
    
    // Miniplayer Properties...
    @State var expand = false
    @State var playingImage = "https://firebasestorage.googleapis.com/v0/b/arcticfoxaudio-dev.appspot.com/o/Untitled%20design-41.png?alt=media&token=6898b01a-4aae-4921-96f9-0b2f1f23f244"
    @Namespace var animation

 
    var body: some View {
        
        let defaults = UserDefaults.standard
        let firstnameSaved = defaults.string(forKey: "Firstname") ?? ""
        let lastnameSaved = defaults.string(forKey: "Lastname") ?? ""
        let emailSaved = defaults.string(forKey: "Email") ?? ""
        
        if globalProfile.currentTab == "safari.fill" {
            HStack(spacing: 0){
                
                SideTabView()
                
                // Main Content...
                ScrollView(showsIndicators: false, content: {
                    BrowseView()
                })
                           
            }
            
        } else if globalProfile.currentTab == "clock.fill" {
            
            HStack(spacing: 0){
                
                SideTabView()
                
                // Main Content...
                ScrollView(showsIndicators: false, content: {
                    RecentlyView()
                })
                           
            }
            
        } else if globalProfile.currentTab == "gear" {
            
            HStack(spacing: 0){
                
                SideTabView()
                
                // Main Content...
                ScrollView(showsIndicators: false, content: {
                    SettingsView()
                })
                           
            }
            
        } else if expand == true {
            
            Miniplayer(animation: animation, expand: $expand, playingImage: $playingImage)
            
        } else if search == true {
            
            SearchView(searchText: searchText)
            
        } else {

                HStack(spacing: 0){
                    
                    SideTabView()
                    
                    VStack{
                        Miniplayer(animation: animation, expand: $expand, playingImage: $playingImage).padding(.top, 1).background(.white)
                    // Main Content...
                    ScrollView(showsIndicators: false, content: {
                        
                        VStack(spacing: 15){
                            
                            HStack(spacing: 15){
                                
                                HStack(spacing: 15){
                                    
                                    Circle()
                                        .stroke(Color.black,lineWidth: 4)
                                        .frame(width: 25, height: 25)
                                    
                                    TextField("Search...", text: $searchText)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        if searchText != "" {
                                            search.toggle()
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
                                
                                Text(initials)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("logoColor"))
                                    .frame(width:40)
                                    .padding(5)
                                
                            }
                            
                            
                            Text("Picks For You")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top,30)
                            
                            // Carousel List...
                            TabView{
                                
                                ForEach(self.globalProfile.recentCard, id: \.self, content: {
                                    recentcard in
                                    
                                    GeometryReader{proxy in
                                        
                                        ZStack(alignment: .bottomLeading){
                                            
                                            RecentArt(recentcard: recentcard).aspectRatio(contentMode: .fill).onTapGesture {
                                                globalProfile.playingImageURL = recentcard.coverImage
                                                globalProfile.playingTitle = recentcard.title
                                                //Add in the stuff for staging the audio files and also playing the ones already downloaded
                                                // will probably have to be a new global function that you put together to make those two work.
                                               // playerProfile.playClicked(audioFileURL: recentcard.)
                                                playingImage = recentcard.coverImage
                                                expand.toggle()
                                                }.frame(width: proxy.frame(in: .global).width)
                                                 .cornerRadius(20)

                                        }
                                    }
                                    .padding(.horizontal)
                                    .frame(height: 550)
                                })
                            }
                            // max Frame...
                            .frame(height: 550)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .padding(.top,20)
                            
                            Text("Genres")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top,30)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 20, content: {
           
                                // List Of Genres...
                                ForEach(generes,id: \.self){genre in
                                    Button(action: {
                                        globalProfile.currentTab = "safari.fill"
                                        globalProfile.clickedGenre = genre
                                    }, label: {
                                        Text(genre)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.black)
                                            .padding(.vertical,8)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.black.opacity(0.06))
                                            .clipShape(Capsule())
                                        })
                                }
                            })
                            .padding(.top,20)
                            
                            Text("Your Library")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top,30)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2), spacing: 10, content: {

                                // Liked Songs...
                                ForEach(self.globalProfile.homeCard, id: \.self, content: {
                                    homecard in
                                    GeometryReader{proxy in
                                          HomeArt(homecard: homecard).aspectRatio(contentMode: .fill).onTapGesture {
                                              globalProfile.playingImageURL = homecard.coverImage
                                              globalProfile.playingTitle = homecard.title
                                              playingImage = homecard.coverImage
                                              expand.toggle()
                                          }.frame(width: proxy.frame(in: .global).width, height: 250)
                                              // based on index number were changing the corner style...
                                            .clipShape(CustomCorners(corners: [.topLeft,.bottomLeft,.topRight,.bottomRight], radius: 15))
                                        
                                    }.frame(height: 250)
                                    
                                })
                            }).padding(.horizontal)
                             .padding(.top,20)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    })
                    }
                }.onAppear{
                    
                    let letter_one = firstnameSaved[firstnameSaved.index(firstnameSaved.startIndex, offsetBy: 0)]
                    let letter_two = lastnameSaved[lastnameSaved.index(lastnameSaved.startIndex, offsetBy: 0)]
                    initials = "\(letter_one) \(letter_two)"
                    globalProfile.getLibrary(email: emailSaved)
                    globalProfile.getRecents(email: emailSaved)
                    
                }.background(Color("bg").ignoresSafeArea())
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)

        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// Custom Corner for Single Side Corner Image...

struct HomeArt: View {
    var homecard : HomeCard
    var body: some View {
        ZStack(alignment: .bottom, content: {
            let url = URL(string: homecard.coverImage)!
            KFImage.url(url).resizable()
        })
    }
    
}


struct RecentArt: View {
    var recentcard : RecentCard
    var body: some View {
        ZStack(alignment: .bottom, content: {
            let url = URL(string: recentcard.coverImage)!
            KFImage.url(url).resizable()
        })
    }
    
}


struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
