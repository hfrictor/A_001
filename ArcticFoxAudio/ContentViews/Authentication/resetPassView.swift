//
//  resetPassView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/11/21.
//

import SwiftUI

struct resetPassView: View {
    
    @State var email = ""
    
    //@EnvironmentObject var authProfile: AuthProfile
    
    var body: some View {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                VStack {
                    
                    
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    
                    Button (action: {
                        guard !email.isEmpty else {
                            return
                        }
                        
                        
                        
                    }, label: {
                        Text("Send Reset Instructions")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(8)
                        
                    })
                    
                }
                .padding()
                
                Spacer()
            }

        }
    }


