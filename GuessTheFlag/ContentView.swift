//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Javier Alaves on 3/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var scoreCount: Int = 0
    @State private var alertMessage: String = ""
    @State private var roundCount: Int = 0
    @State private var newGame: Bool = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled() // to randomize the array each session
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.headline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreCount)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(alertMessage)")
        }
        .alert("Game Over", isPresented: $newGame) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your final score was \(scoreCount)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
            alertMessage = "Your score is \(scoreCount)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "That's the flag of \(countries[number])"
        }
        
        showScore = true
        roundCount += 1
        resetAlert()
        resetGame()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetAlert() {
        if roundCount == 8 {
            newGame = true
        }
    }
    
    func resetGame() {
        if roundCount == 8 {
            scoreCount = 0
            roundCount = 0
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
