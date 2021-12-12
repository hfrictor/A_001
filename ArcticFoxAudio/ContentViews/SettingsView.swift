//
//  SettingsView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,30)
            .padding(.leading,15)
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
