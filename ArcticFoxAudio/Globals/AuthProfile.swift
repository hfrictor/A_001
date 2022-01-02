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
    
    //Authentication variables
    @Published var signedIn = false
    @Published var isSubscribed = true
    
    
    //User variables
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var email = ""
    @Published var initials = ""
    
    @Published var userLibrary = []
    @Published var userRecents = []
    
    @Published var listeningTime = 0
    @Published var timePerBook = 0
    
    @Published var resetEmail = ""
    
    
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
    
    
    func createNewUser(entered_email: String, entered_firstname: String, entered_lastname: String, entered_password: String) {
        //Firestore Architecture for Making user structure and storing data related to the user
        let userData: [String: Any] = [
            "firstname" : entered_firstname,
            "lastname" : entered_lastname,
            "currentPassword" : entered_password,
            "newPassword" : self.newPassword,
            "email" : entered_email,
            "userLibrary" : self.userLibrary,
            "userRecents" : self.userRecents,
            "listeningTime" : self.listeningTime,
            "timePerBook" : self.timePerBook
            
        ]
        
            let db = Firestore.firestore()
        
        let userRef = db.collection("Users").document(entered_email)

                    userRef.setData(userData) { error in
                        if let error = error {
                            print("Error writing document: \(error)")
                        } else {
                            print("Users Document successfully written!")
                        }
                        
                    }
        DispatchQueue.main.async {
            print("Signed Up User Successfully")
        }
        
    }
    
    func loadUser(entered_email: String) {
        let db = Firestore.firestore()

            let docRef = db.collection("Users").document(entered_email)

            docRef.getDocument { (document, error) in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }

                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        print("data", data)
                        self.firstname = data["firstname"] as? String ?? ""
                        self.lastname = data["lastname"] as? String ?? ""
                        self.newPassword = data["newPassword"] as? String ?? ""
                        
                        self.userLibrary = data["userLibrary"] as? Array ?? [""]
                        self.userRecents = data["userRecents"] as? Array ?? [""]
                        
                    }
                }

            }
        
        DispatchQueue.main.async {
            print("Loaded User Successfully")
            
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
    
    func signUp(email: String, password: String, entered_firstname: String, entered_lastname: String) {
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
                defaults.set(entered_firstname, forKey: "Firstname")
                defaults.set(entered_lastname, forKey: "Lastname")
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

    func deleteUserAuth() {
        try? auth.signOut()
        
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "Email")
        defaults.set("", forKey: "Password")
        
        self.signedIn = false
    }
    
    
    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: resetEmail) { error in
          print("Resetting Password")
        }
    }
    
}
