//
//  SettingsView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var confirmpassword = ""
    
    // Miniplayer Properties...
    @State var expand = false
    @State var playingImage = ""
    @Namespace var animation
    
    @EnvironmentObject var authProfile: AuthProfile
    
    
    func updateUser() {
        //Firestore Architecture for Making user structure and storing data related to the user
        let userData: [String: Any] = [
            "firstname" : authProfile.firstname,
            "lastname" : authProfile.lastname,
            "currentPassword" : authProfile.currentPassword,
        ]
        
            let db = Firestore.firestore()
        
        let userRef = db.collection("Users").document(email)

                    userRef.updateData(userData) { error in
                        if let error = error {
                            print("Error writing document: \(error)")
                        } else {
                            print("Users Document successfully written!")
                        }
                    }
        DispatchQueue.main.async {
            print("Signed Up User Successfully")
            let defaults = UserDefaults.standard
            defaults.set(authProfile.firstname, forKey: "Firstname")
            defaults.set(authProfile.lastname, forKey: "Lastname")
        }
    }
    
    
    var body: some View {
        
        let defaults = UserDefaults.standard
        let emailSaved = defaults.string(forKey: "Email") ?? ""
        
        // Home View...
        VStack{
            Miniplayer(animation: animation, expand: $expand, playingImage: $playingImage).padding(.top, 1).background(.white)
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 18){
                    // Graph View....
                    BarGraph(downloads: downloads)
                    
                    // Users View...
                    HStack(spacing: 0){
                        
                        UserProgress(title: "To Kill a Mocking Bird", color: Color("LightBlue"), image: "book", progress: 68)
                        
                        UserProgress(title: "Harry Potter", color: Color("LightBlue"), image: "book", progress: 72)
                        
                        UserProgress(title: "Unstoppable", color: Color("Pink"), image: "book", progress: 12)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                    
                    // Most Downloads...
                    VStack{
                            
                            HStack{
                                
                                VStack(alignment: .leading, spacing: 10, content: {
                                    Text("Settings")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                    Text("Change information then save changes by pressing the button below.")
                                        .foregroundColor(.gray)
                                })
                                
                                Spacer(minLength: 15)
                            }
                            
                            VStack {
                                HStack(spacing: 15){
                                    
                                    Text("First")
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .fill(Color("logoColor"))
                                        .frame(width: 1, height: 18)
                                    
                                    TextField("", text: $authProfile.firstname)
                                }
                                
                                Divider()
                                    .background(Color("logoColor"))
                            }.padding(.vertical)
                            
                            VStack {
                                HStack(spacing: 15){
                                    
                                    Text("Last")
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .fill(Color("logoColor"))
                                        .frame(width: 1, height: 18)
                                    
                                    TextField("", text: $authProfile.lastname)
                                }
                                
                                Divider()
                                    .background(Color("logoColor"))
                            }.padding(.vertical)
                            
                            VStack {
                                HStack(spacing: 15){
                                    
                                    Text("Email")
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .fill(Color("logoColor"))
                                        .frame(width: 1, height: 18)
                                    
                                    TextField("", text: $email)
                                }
                                
                                Divider()
                                    .background(Color("logoColor"))
                            }.padding(.vertical)
                            
                            VStack {
                                HStack(spacing: 15){
                                    
                                    Text("New Password")
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .fill(Color("logoColor"))
                                        .frame(width: 1, height: 18)
                                    
                                    TextField("", text: $password)
                                }
                                
                                Divider()
                                    .background(Color("logoColor"))
                            }.padding(.vertical)
                            
                            VStack {
                                HStack(spacing: 15){
                                    
                                    Text("Confirm Pass")
                                        .foregroundColor(.black)
                                    
                                    Rectangle()
                                        .fill(Color("logoColor"))
                                        .frame(width: 1, height: 18)
                                    
                                    TextField("", text: $confirmpassword)
                                }
                                
                                Divider()
                                    .background(Color("logoColor"))
                            }.padding(.vertical)
                            
                            
                            Button(action: {
                               updateUser()
                            }, label: {
                                Text("Save Changes")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(width: 300)
                                    .background(Color("logoColor"))
                                    .clipShape(Capsule())
                            })
                        
                        HStack {
                            Button(action: {
                                
                                authProfile.deleteUserAuth()
                               
                            }, label: {
                                Text("Delete")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(width: 120)
                                    .background(.red)
                                    .clipShape(Capsule())
                            })
                            
                            Button(action: {
                                
                                authProfile.signOut()
                               
                            }, label: {
                                Text("Logout")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(width: 120)
                                    .background(.black)
                                    .clipShape(Capsule())
                            })
                        }.padding(.top, 15)

                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)
                }
                .padding()
            }.onAppear{
                email = emailSaved
            }
        }.navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func UserProgress(title: String,color: Color,image: String,progress: CGFloat)->some View{
        
        HStack{
            
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(color)
                .padding(10)
                .background(
                
                    ZStack{
                        
                        Circle()
                            .stroke(Color.gray.opacity(0.3),lineWidth: 2)
                        
                        Circle()
                            .trim(from: 0, to: progress / 100)
                            .stroke(color,lineWidth: 2)
                            .rotationEffect(.init(degrees: -90))
                    }
                )
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("\(Int(progress))%")
                    .fontWeight(.bold)
                
                Text(title)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

