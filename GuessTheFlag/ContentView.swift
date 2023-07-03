//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Javier Alaves on 3/7/23.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                }
                .foregroundStyle(.white)
                
                ForEach(0..<3) { number in
                    Button {
                        // flag was tapped
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
