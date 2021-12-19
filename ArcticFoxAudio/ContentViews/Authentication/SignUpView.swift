//
//  SignInView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct SignUpView: View {
    
    @State var isSignedUp = false
    @State var isOnbarded = false
    @State var show = false
    
    @State var firstname = ""
    @State var lastname = ""
    @State var email = ""
    @State var password = ""
    @State var confirmpassword = ""
    
    @State var emailExists = false
    @State var usernameExists = false
    @State var notFilledOut = false
    
    @EnvironmentObject var authProfile: AuthProfile
    
    
    func checkEmail(enteredEmail: String) {
        
        self.emailExists = false
        DispatchQueue.main.async {
        Firestore.firestore().collection("Users").whereField("email", isEqualTo: enteredEmail)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("Email does not exist")
                    self.emailExists = false
                } else {
                    self.emailExists = true
                }

       
            print("Successfully Checked If Email Exists")
        }
    }
    }
    
        
    func checkUsername(enteredUsername: String) {
        
        self.usernameExists = false
        DispatchQueue.main.async {
        
        Firestore.firestore().collection("Users").whereField("username", isEqualTo: enteredUsername)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("Username does not exist")
                    self.usernameExists = false
                } else {
                    self.usernameExists = true
                }

       
            print("Successfully Checked If Username Exists")
        }
    }
        
    }
    
    
    func tryLogin() {
        
        guard !email.isEmpty, !password.isEmpty, !firstname.isEmpty, !lastname.isEmpty else {
            notFilledOut = true
            return
        }
        checkEmail(enteredEmail: email)
        if emailExists == true {
            
        } else if usernameExists == true {
            
        } else if usernameExists == false && emailExists == false {
            authProfile.signUp(email: email, password: password)
           // authProfile.createNewUser(entered_email: email, entered_firstname: firstname, entered_lastname: lastname, entered_password: password)
        } else {
            
        }
    }
    
    var body: some View {
        
        NavigationView {
            if isSignedUp == true {
                SplashScreen()
            } else if isOnbarded == true {
                OnboardingView()
            }else {
                ScrollView {
                    VStack{
                        
                        ZStack {
                            
                            Color("bg")
                                .ignoresSafeArea()
                            
                            VStack{
                              
                                VStack{
                                    
                                    HStack{
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            Text("Signup")
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            
                                            Text("Enter your information to continue")
                                                .foregroundColor(.gray)
                                        })
                                        
                                        Spacer(minLength: 15)
                                    }
                                    
                                    VStack {
                                        HStack(spacing: 15){
                                            
                                            Text("First")
                                                .foregroundColor(.black)
                                            
                                            Rectangle()
                                                .fill(Color("logoColor"))
                                                .frame(width: 1, height: 18)
                                            
                                            TextField("", text: $firstname)
                                        }
                                        
                                        Divider()
                                            .background(Color("logoColor"))
                                    }.padding(.vertical)
                                    
                                    VStack {
                                        HStack(spacing: 15){
                                            
                                            Text("Last")
                                                .foregroundColor(.black)
                                            
                                            Rectangle()
                                                .fill(Color("logoColor"))
                                                .frame(width: 1, height: 18)
                                            
                                            TextField("", text: $lastname)
                                        }
                                        
                                        Divider()
                                            .background(Color("logoColor"))
                                    }.padding(.vertical)
                                    
                                    VStack {
                                        HStack(spacing: 15){
                                            
                                            Text("Email")
                                                .foregroundColor(.black)
                                            
                                            Rectangle()
                                                .fill(Color("logoColor"))
                                                .frame(width: 1, height: 18)
                                            
                                            TextField("", text: $email)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Divider()
                                            .background(Color("logoColor"))
                                    }.padding(.vertical)
                                    
                                    VStack {
                                        HStack(spacing: 15){
                                            
                                            Text("Password")
                                                .foregroundColor(.black)
                                            
                                            Rectangle()
                                                .fill(Color("logoColor"))
                                                .frame(width: 1, height: 18)
                                            
                                            SecureField("", text: $password)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                        }
                                        
                                        Divider()
                                            .background(Color("logoColor"))
                                    }.padding(.vertical)
                                    
                                    VStack {
                                        HStack(spacing: 15){
                                            
                                            Text("Confirm Pass")
                                                .foregroundColor(.black)
                                            
                                            Rectangle()
                                                .fill(Color("logoColor"))
                                                .frame(width: 1, height: 18)
                                            
                                            SecureField("", text: $confirmpassword)
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                                
                                        }
                                        
                                        Divider()
                                            .background(Color("logoColor"))
                                    }.padding(.vertical)
                                    
                                    
                                    Button(action: {
                                        tryLogin()
                                    }, label: {
                                        Text("Signup")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .frame(width: UIScreen.main.bounds.width - 60)
                                            .background(Color("logoColor"))
                                            .clipShape(Capsule())
                                    })
                                    
                                    NavigationLink("Back to Login", destination: LoginView())
                                    
                                    Spacer()
                                    
                                    NavigationLink("Need Help Signing in? Reset Password", destination: resetPassView())
                                    
                                    
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .padding()
                                
                                
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle("")
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
}

