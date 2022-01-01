//
//  BlurView.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/14/21.
//

import SwiftUI

//struct BlurView: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> UIVisualEffectView {
//
//        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
//
//
//    }
//}


struct BlurView: View {
    var body: some View {
        Image("bg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 20)
    }
}
