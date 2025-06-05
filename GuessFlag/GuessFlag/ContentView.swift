//
//  ContentView.swift
//  GuessFlag
//
//  Created by Aslan Korkmaz on 2.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "UK", "Ukraine", "Spain", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreNumber = 0
    @State private var numberOfQuestion = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top , startRadius: 200, endRadius: 700)
            .ignoresSafeArea(edges: .all)
            
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Group {
                            Text("Question number: \(numberOfQuestion)")
                            Text("8 is final score")
                        }
                        .font(.footnote)
                        .foregroundColor(.white)
                        
                    }
                    Spacer()
                }
                
                
                Spacer()
                Text("Gues the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreNumber)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle,isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(scoreNumber)")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart", action: resetGame)
        } message: {
            Text("You answered 8 questions. \nYour final score is: \(scoreNumber)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreNumber += 1
        } else  {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            scoreNumber -= 1
        }
        numberOfQuestion += 1
        
        if numberOfQuestion == 8 {
            gameOver = true
        } else {
            showingScore = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        scoreNumber = 0
        numberOfQuestion = 0
        askQuestion()
    }
}
#Preview {
    ContentView()
}
