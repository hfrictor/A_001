//
//  BookView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/6/21.
//

import SwiftUI
import Kingfisher
import Firebase

struct BookView: View {
    
    @EnvironmentObject var globalProfile: GlobalProfile
    @EnvironmentObject var authProfile: AuthProfile
    @EnvironmentObject var playerProfile: PlayerProfile
    
    @State var isadded = false
    
    func addToLibrary() {
        let db = Firestore.firestore()
        let bookRef = db.collection("Users").document(authProfile.email)

        bookRef.updateData([
            "userLibrary": FieldValue.arrayUnion([globalProfile.browseCode])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Book Added to Library!")
                self.isadded.toggle()
            }
        }
    }
    
    
    
    
    var body: some View {
        ScrollView() {
            VStack() {
                
                if globalProfile.browseImageURL != "" {
                    let url = URL(string: globalProfile.browseImageURL)!
                    KFImage.url(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 500)
                        .cornerRadius(15)
                        .padding()
                        
                } else {
                    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/arcticfoxaudio-dev.appspot.com/o/Untitled%20design-41.png?alt=media&token=6898b01a-4aae-4921-96f9-0b2f1f23f244")!
                    KFImage.url(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 400)
                        .cornerRadius(15)
                        .padding()
                }
                
                
                Text(globalProfile.browseTitle)
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding()
                
                
                Text("By: \(globalProfile.browseAuthor)")
                    .font(.title2)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding(10)
                
                
                
                Button(action: {
                    addToLibrary()
                    
                }, label: {
                    Text(isadded ? "Added To Library" : "Add To Library")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .frame(width: UIScreen.main.bounds.width - 60)
                        .background(Color("logoColor"))
                        .clipShape(Capsule())
                })
                
                
                Text(globalProfile.browseDescription)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .lineLimit(nil)
                    .padding()
                
                
                
            }
        }
    }
}
