//
//  SignInView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI


struct SignUpView: View {
    
    @State var isSignedUp = false
    @State var isOnbarded = false
    @State var show = false
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var confirmpassword = ""
    
    var body: some View {
        NavigationView {
            if isSignedUp == true {
                SplashScreen()
            } else if isOnbarded == true {
                OnboardingView()
            }else {
                ScrollView {
                    VStack{
                        
                        ZStack {
                            
                            Color("bg")
                                .ignoresSafeArea()
                            
                            VStack{
                              
                                VStack{
                                    
                                    HStack{
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            Text("Signup")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            
                                            Text("Enter your information to continue")
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
                                            
                                            TextField("", text: $firstname)
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
                                            
                                            TextField("", text: $lastname)
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
                                            
                                            Text("Password")
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
                                        isOnbarded.toggle()
                                    }, label: {
                                        Text("Signup")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .frame(width: UIScreen.main.bounds.width - 60)
                                            .background(Color("logoColor"))
                                            .clipShape(Capsule())
                                    })
                                    
                                    
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .padding()
                                
                                
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
}

