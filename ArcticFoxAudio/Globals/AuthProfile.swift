//
//  AuthProfile.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/12/21.
//

import Foundation
import SwiftUI
import Firebase

class AuthProfile: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var isSubscribed = true
    @Published var email = ""
    
    var isSignedIn: Bool {
        if Auth.auth().currentUser != nil {
           print("user exists")
            return true
        }
        else {
           print("No user")
            return false
        }
    }
    
   
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.email = email
                self?.signedIn = true
                
                let defaults = UserDefaults.standard
                defaults.set(email, forKey: "Email")
                defaults.set(password, forKey: "Password")
                print("Signed in now @@@@@@@@@@@@@@@@@@@@@@@@@@@@")
               
            }
        }
        
        
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Success
            DispatchQueue.main.async {
                self?.email = email
                self?.signedIn = true
                
                let defaults = UserDefaults.standard
                defaults.set(email, forKey: "Email")
                defaults.set(password, forKey: "Password")
            }
        }
    }
    
    
    func signOut() {
        try? auth.signOut()
        
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "Email")
        defaults.set("", forKey: "Password")
        
        self.signedIn = false
    }
   
    func reloadUser(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.reload(completion: { (error) in
            callback?(error)
        })
        self.signedIn = false
  
    }
    
    
    func checkSubscription() {
        
    }
    
    func deleteUserAuth() {
        
    }
    
}
