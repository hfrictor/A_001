//
//  SignInView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        SplashScreen()
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
           
                if test != nil{
                    HomeView()
                    //IntroScreen()
            
                }else{
                    IntroScreen()
                }
            
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
        }
        
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


struct IntroScreen: View {
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        ZStack{
            
            DotInversion(currentIndex: $currentIndex)
                .ignoresSafeArea()
            
            // Indicators...
            HStack(spacing: 10){
                
                ForEach(tabs.indices,id: \.self){index in
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .opacity(currentIndex == index ? 1 : 0.3)
                        .scaleEffect(currentIndex == index ? 1.1 : 0.8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(25)
            
            // Skip Button..
            Button("Skip"){
                HomeView()
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

struct DotInversion: View {
    
    // CurrentState...
    @State var dotState: DotState = .normal
    // Scale Value...
    @State var dotScale: CGFloat = 1
    
    // Rotation..
    @State var dotRotation: Double = 0
    
    // To avoid multiple taps...
    @State var isAnimating = false
    
    // Current And Next Index...
    @Binding var currentIndex: Int
    @State var nextIndex: Int = 1
    
    var body: some View {
        
        ZStack{
            
            ZStack{
                
                // Changing color based on state...
                (dotState == .normal ? tabs[currentIndex].color : tabs[nextIndex].color)
                
                if dotState == .normal{
                    MinimisedView()
                }
                else{
                    ExpandedView()
                }
            }
            .animation(.none, value: dotState)
            
            Rectangle()
                .fill(dotState != .normal ? tabs[currentIndex].color : tabs[nextIndex].color)
                .overlay(
                
                    ZStack{
                        
                        // Put View in reverse...
                        // so that it will look like masking effect...
                        // changing view based on state...
                        if dotState != .normal{
                            MinimisedView()
                        }
                        else{
                            ExpandedView()
                        }
                    }
                )
                .animation(.none, value: dotState)
            // Masking The view with cirlce to create dot inversion animation...
                .mask(
                
                    GeometryReader{proxy in
                        
                        Circle()
                        // While increasing the scale the content will be visible...
                            .frame(width: 80, height: 80)
                            .scaleEffect(dotScale)
                            .rotation3DEffect(.init(degrees: dotRotation), axis: (x: 0, y: 1, z: 0), anchorZ: dotState == .flipped ? -10 : 10, perspective: 1)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            .offset(y: -(getSafeArea().bottom + 20))
                    }
                )
            
            // For Tap Gesture....
            Circle()
                .foregroundColor(Color.black.opacity(0.01))
                .frame(width: 80, height: 80)
            // Arrow...
                .overlay(
                
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(.white)
                    //opactiy animation...
                        .opacity(dotRotation == -180 ? 0 : 1)
                        .animation(.easeInOut, value: dotRotation)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .onTapGesture(perform: {
                    
                    if isAnimating{return}
                    
                    isAnimating = true
                    
                    
                    // Modifying for single Tap...
                    
                    // At mid of 1.5 just resetting the scale to again 1...
                    // so that it will be look like dot inversion...
                    
                    withAnimation(.linear(duration: 1.5)){
                        dotRotation = -180
                        dotScale = 8
                    }
                    
                    // To get correct timing ...
                    // just trail and error the delay value....
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.725) {
                        
                        // 1.5/2 = 0.7
                        
                        // Updating Animation...
                        withAnimation(.easeInOut(duration: 0.71)){
                            dotState = .flipped
                        }
                    }
                    
                    // Reversing it with little Speed.
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        
                        withAnimation(.easeInOut(duration: 0.5)){
                            dotScale = 1
                        }
                    }
                    
                    // After 1.4s resetting isAnimating State...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        
                        // Resetting to default....
                        withAnimation(.easeInOut(duration: 0.3)){
                            
                            dotRotation = 0
                            dotState = .normal
                            
                            // updating index...
                            // setting current index as next index...
                            currentIndex = nextIndex
                            // updating next index...
                            nextIndex = getNextIndex()
                        }
                        
                        // Since animation has been added for 0.3s...
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            
                            isAnimating = false
                        }
                    }
                })
                .offset(y: -(getSafeArea().bottom + 20))
            
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func IntroView(tab: Tab)->some View{
        
        VStack{
            
            Image(tab.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width - 80)
                .padding(.bottom, getRect().height < 750 ? 20 : 40)
                .padding(.top,40)
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text(tab.title)
                    .font(.system(size: 45))
                
                Text(tab.subTitle)
                    .font(.system(size: 50, weight: .bold))
                
                Text(tab.description)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100,alignment: .leading)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading,20)
            .padding([.trailing,.top])
        }
    }
    
    func getNextIndex()->Int{
        
        // Simply looping if last index came....
        // so that it will look like infinite carousel...
        let index = (nextIndex + 1) > (tabs.count - 1) ? 0 : (nextIndex + 1)
        
        return index
    }
    
    // Expanded and Minimised Views....
    @ViewBuilder
    func ExpandedView()->some View{

        IntroView(tab: tabs[nextIndex])
            .offset(y: -50)
    }
    
    @ViewBuilder
    func MinimisedView()->some View{
        

        IntroView(tab: tabs[currentIndex])
            .offset(y: -50)
    }
}

struct DotInversion_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

// Enum for current Dot State...
enum DotState{
    case normal
    case flipped
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


