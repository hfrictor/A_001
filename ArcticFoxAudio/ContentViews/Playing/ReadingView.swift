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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ReadingView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingView()
    }
}
