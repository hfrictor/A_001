//
//  resetPassView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/11/21.
//

import SwiftUI

struct resetPassView: View {
    
    @EnvironmentObject var authProfile: AuthProfile
    
    @State private var showingAlert = false
    
    var body: some View {
        
            VStack {
                Image("LogoFox")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                VStack {
                    
                    
                    TextField("Email Address", text: $authProfile.resetEmail)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    
                    Button (action: {
                        guard !authProfile.resetEmail.isEmpty else {
                            return
                        }
                        
                        authProfile.resetPassword()
                        showingAlert.toggle()
                        
                    }, label: {
                        Text("Send Reset Instructions")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color("logoColor"))
                            .cornerRadius(8)
                        
                    }).alert("Email with reset instructions has been sent to \(authProfile.resetEmail). Contact support if you have other problems signing in.", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    
                }
                .padding()
                
                Spacer()
            }

        }
    }


