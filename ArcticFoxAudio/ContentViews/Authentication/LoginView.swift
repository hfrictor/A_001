//
//  LoginView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Lottie

struct LoginView: View {
    
    @State var isLoggedIn = false
    @State var isSignedUp = true
    @State var show = false
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {

            if isLoggedIn == true {
                SplashScreen()
            } else if isSignedUp == false{
                SignUpView()
            } else {
                    
                    VStack{
                        
                        ZStack {
                            
                            Color("bg")
                                .ignoresSafeArea()
                            
                            VStack{
                                
                                AnimatedView(show: $show)
                                // default Frame....
                                    .frame(width: UIScreen.main.bounds.height / 2, height: UIScreen.main.bounds.height / 4)
                                    .padding(.bottom,-35)
                                
                                VStack{
                                    
                                    HStack{
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            Text("Login")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            
                                            Text("Enter your email to continue")
                                                .foregroundColor(.gray)
                                        })
                                        
                                        Spacer(minLength: 15)
                                    }
                                    
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
                                    }
                                    .padding(.vertical)
                                    
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
                                    }
                                    .padding(.vertical)
                                    
                                    Button(action: {
                                        isLoggedIn.toggle()
                                        
                                    }, label: {
                                        Text("Login")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .frame(width: UIScreen.main.bounds.width - 60)
                                            .background(Color("logoColor"))
                                            .clipShape(Capsule())
                                    })
                                    
                                    Button(action: {isSignedUp.toggle()}, label: {
                                        Text("Signup")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .frame(width: UIScreen.main.bounds.width - 60)
                                            .background(Color("logoColor"))
                                            .clipShape(Capsule())
                                    })
                                    
                                    HStack{
                                        
                                        Rectangle()
                                            .fill(Color.black.opacity(0.3))
                                            .frame(height: 1)
                                        
                                        Text("OR")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.black.opacity(0.3))
                                        
                                        Rectangle()
                                            .fill(Color.black.opacity(0.3))
                                            .frame(height: 1)
                                    }
                                    .padding(.vertical,10)
                                    
                                    HStack(spacing: 20){
                                        
                                        Button(action: {}, label: {
                                            
                                            HStack(spacing: 10){
                                                
                                                Image("fb")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                                
                                                Text("Facebook")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.vertical,10)
                                            .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                                            .background(Color("fb"))
                                            .clipShape(Capsule())
                                        })
                                        
                                        Button(action: {}, label: {
                                            
                                            HStack(spacing: 10){
                                                
                                                Image("google")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                                
                                                Text("Google")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.vertical,10)
                                            .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                                            .background(Color("google"))
                                            .clipShape(Capsule())
                                        })
                                    }
                                    NavigationLink("Need Help Signing in? Reset Password", destination: resetPassView())
                                        .padding()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .padding()
                                
                                // Bottom To up Transition..
                                
                                // we can acheive this by frame property...
                                .frame(height: show ? nil : 0)
                                .opacity(show ? 1 : 0)
                            }
                        }
                    }
                }
            }.navigationBarTitle("")
             .navigationBarHidden(true)
             .navigationBarBackButtonHidden(true)
        }
    
}


// Animated View...

struct AnimatedView: UIViewRepresentable {
    
    @Binding var show: Bool
    
    func makeUIView(context: Context) -> AnimationView{
        
        let view = AnimationView(name: "splash", bundle: Bundle.main)
        
        // on Complete....
        view.play { (status) in
            
            if status{
                
                // toggling view...
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    show.toggle()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
        
    }
}


struct SplashScreen: View{
    
    
    // Animating...
    @State var splashAnimation: Bool = false
    
    @Environment(\.colorScheme) var scheme
    
    @State var removeSplashScreen: Bool = false
    
    var body: some View{
        
        let defaults = UserDefaults.standard
        let emailSaved = defaults.string(forKey: "Email")
        let passwordSaved = defaults.string(forKey: "Password")
        
        let test = "something"
        
        ZStack{
            
            NavigationView{
                HomeView()
            
            }.navigationBarTitle("")
             .navigationBarHidden(true)
             .navigationBarBackButtonHidden(true)
            
            
            
            if !removeSplashScreen{
                
                Color("logoColor")
                // Masking With Twitter SVG Image...
                // From xcode 12 we can directly use svg from assets catalouge....
                    .mask(
                    
                        // Reverse masking with the help of bending....
                        Rectangle()
                            .overlay(
                            
                                Image("LogoFox")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .scaleEffect(splashAnimation ? 35 : 1)
                                    .blendMode(.destinationOut)
                            )
                    )
                    .ignoresSafeArea()
            }
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
        // avoiding dark twitter color...
        .preferredColorScheme(splashAnimation ? nil : .light)
        .onAppear {
            
            // Animating with slight delay of 0.4s...
            // for smooth animation...
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                
                withAnimation(.easeInOut(duration: 0.3)){
                    splashAnimation.toggle()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                    removeSplashScreen = true
                }
            }
        }
    }
}


// Extending View to get Screen Rect...
extension View{
    
    func getCurrentRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getCurrentSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}




