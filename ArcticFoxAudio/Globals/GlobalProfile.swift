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

    @Published var homeCard = [HomeCard]()
    
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
                print(error)
            }
        }
    }
 
}
