//
//  GlobalProfile.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/12/21.
//

import Foundation
import SwiftUI
import Firebase

class GlobalProfile: ObservableObject {
    
    @Published var currentTab = "house.fill"
    @Published var clickedGenre = "Browse"
    
    @Published var playingImageURL = "https://firebasestorage.googleapis.com/v0/b/arcticfoxaudio-dev.appspot.com/o/Untitled%20design-41.png?alt=media&token=6898b01a-4aae-4921-96f9-0b2f1f23f244"
    @Published var playingTitle = "Click a Title to Play"
    @Published var playingUrl = ""

    @Published var homeCard = [HomeCard]()
    @Published var recentCard = [RecentCard]()
    
    @State var arrayIndex = 0
    
    @Published var library_array = []
    @Published var recent_array = ["PrideandPrejudiceJaneAusten1813-12-26-2021-1643003423", "CrimeandPunishmentFyodorDostoevsky1866-12-26-2021-9481068210"]
    
    
    func getLibrary(email: String) {
            Firestore.firestore().collection("Users").document(email).getDocument {
                (document, error) in
                if let document = document {
                    let library_array = document["userLibrary"] as? Array ?? [""]
                    print(library_array)
                    
                    for title in library_array{
                        //add the afh codes to an array for the home screen
                        self.library_array.append(title)
                }
            }
            
        }
    
        DispatchQueue.main.async {
            print("Successfully Fetched Library Info")
            self.getbook()
        }
    }
    
    
    
    func getRecents(email: String) {
            Firestore.firestore().collection("Users").document(email).getDocument {
                (document, error) in
                if let document = document {
                    let recents_array = document["userRecents"] as? Array ?? [""]
                    print(recents_array)
                    
                    for title in recents_array{
                        //add the afh codes to an array for the home screen
                        self.recent_array.append(title)
                }
            }
            
        }
    
        DispatchQueue.main.async {
            print("Successfully Fetched Recents Info")
            for i in self.recent_array{
                self.getrecentbooks(recentarray: i as! String)
            }
        }
    }
    
    
    
    func getbook() {
        Firestore.firestore().collection("books").getDocuments { (snapshot, error) in
            if error == nil {
                for document in snapshot!.documents {
                    let title = document.data()["Title"] as? String ?? "error"
                    let author = document.data()["Author"] as? String ?? "error"
                    let description = document.data()["Description"] as? String ?? "error"
                    let pubDate = document.data()["PublicationDate"] as? String ?? "error"
                    let coverImage = document.data()["CoverImage"] as? String ?? "error"
                    let afhCode = document.data()["AFH_Code"] as? String ?? "error"
                    
                    
                    self.homeCard.append(HomeCard(title: title, author: author, description: description, pubDate: pubDate, coverImage: coverImage, afhCode: afhCode))
                }
            } else {
                print(error ?? "Error with the getbook() fucntion")
            }
        }
    }
    
    
    
    
    func getrecentbooks(recentarray: String) {

            Firestore.firestore().collection("books").whereField("AFH_Code", isEqualTo: recentarray).getDocuments() { (snapshot, error) in
                if error == nil {
                    for document in snapshot!.documents {
                        let title = document.data()["Title"] as? String ?? "error"
                        let author = document.data()["Author"] as? String ?? "error"
                        let description = document.data()["Description"] as? String ?? "error"
                        let pubDate = document.data()["PublicationDate"] as? String ?? "error"
                        let coverImage = document.data()["CoverImage"] as? String ?? "error"
                        let afhCode = document.data()["AFH_Code"] as? String ?? "error"
                        
                        self.arrayIndex = self.arrayIndex+1
                        
                        self.recentCard.append(RecentCard(title: title, author: author, description: description, pubDate: pubDate, coverImage: coverImage, afhCode: afhCode))
                    }
                } else {
                    print(error ?? "Error with the getrecentbooks() function.")
                }
            }
        
    }
 
}
