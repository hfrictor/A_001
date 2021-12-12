//
//  Tab.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/8/21.
//

import Foundation
import SwiftUI

// Tab Model and sample Intro Tabs....
struct Tab: Identifiable{
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var image: String
    var color: Color
}

// Add more tabs for more intro screens....
var tabs: [Tab] = [

    Tab(title: "Listen", subTitle: "for Free", description: "Listen to thousands of audiobooks from top authors all free of charge!", image: "Pic2",color: Color("Green")),
    Tab(title: "Customize", subTitle: "Notes and Bookmarks", description: "Customize your eperience using Arctic Fox Audios propreitary listening features!", image: "Pic3",color: Color("DarkGrey")),
    Tab(title: "", subTitle: "", description: "", image: "",color: Color("Yellow")),
]
