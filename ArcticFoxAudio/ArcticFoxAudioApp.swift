//
//  ArcticFoxAudioApp.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Firebase
import SwiftAudioPlayer

@main
struct ArcticFoxAudioApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate 
    var body: some Scene {
        WindowGroup {
            
            let globalProfile = GlobalProfile()
            let authProfile = AuthProfile()
            let playerProfile = PlayerProfile()
            //use LoginView() for final app
            //SplashScreen()
            LoginView()
            .environmentObject(authProfile)
            .environmentObject(globalProfile)
            .environmentObject(playerProfile)

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        if authProfile.isSignedIn == true {
            globalProfile.getRecents(email: emailSaved)
            globalProfile.getLibrary(email: emailSaved)
        } else {
            print("NOT Signed In")
        }
        
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        SAPlayer.Downloader.setBackgroundCompletionHandler(completionHandler)
    }
    
}
