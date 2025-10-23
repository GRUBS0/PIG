//
//  ContentView.swift
//  PIG
//
//  Created by joseph phillips on 10/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var turnScore = 0
    @State private var gameScore = 0
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            VStack {
                Image("Pig").resizable().frame(width:150, height:150)
                CustomText(text: "Pig")
                Spacer()
                CustomText(text: "turnScore: \(turnScore)")
                CustomText(text: "gameScore: \(gameScore)")
            }
        }
    }
}
struct CustomText: View {
    let text: String
    var body: some View {
        Text (text).font (Font.custom("Marker Felt", size: 36))
        
    }
        
        #Preview {
            ContentView()
        }
    }

