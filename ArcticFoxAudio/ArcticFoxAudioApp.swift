//
//  ArcticFoxAudioApp.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI

@main
struct ArcticFoxAudioApp: App {
    var body: some Scene {
        WindowGroup {
            
            let globalProfile = GlobalProfile()
            //use LoginView() for final app
            HomeView().navigationBarHidden(true)
            .environmentObject(globalProfile)

        }
    }
}
