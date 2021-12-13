//
//  AccountView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var globalProfile: GlobalProfile
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top,30)
                .padding(.leading,15)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
