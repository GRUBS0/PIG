import SwiftUI

struct ContentView: View {

    @State private var turnScore = 0
    @State private var gameScore = 0
    @State private var randomValue = 1
    @State private var rotation = 0.0
    @State private var gameOver = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.7).ignoresSafeArea()

                VStack {

                    Image("Pig").resizable().frame(width: 150, height: 150)
                    CustomText(text: "Pig Game")
                    Image("pips \(randomValue)")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .rotationEffect(.degrees(rotation))
                        .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 1, z: 0))
                        .padding(50)

                    CustomText(text: "Turn Score: \(turnScore)")
                    CustomText(text: "Game Score: \(gameScore)")


                    HStack(spacing: 30) {
                        Button("Roll") {
                            rollDie()
                        }
                        .buttonStyle(CustomButtonStyle())

                        Button("Hold") {
                            holdTurn()
                        }
                        .buttonStyle(CustomButtonStyle())
                    }
                    .padding(.top)


                    NavigationLink(destination: InstructionsView()) {
                        Text("How to Play")
                            .font(Font.custom("Marker Felt", size: 24))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }


                    Button("Reset Game") {
                        resetGame()
                    }
                    .font(Font.custom("Marker Felt", size: 24))
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Spacer()
                }
            }
            .alert("🎉 You Win!", isPresented: $gameOver) {
                Button("OK", role: .cancel) {
                    resetGame()
                }
            } message: {
                Text("Congratulations! You reached 100 points!")
            }
        }
    }


    func endTurn() {
        turnScore = 0
    }

    func rollDie() {
        randomValue = Int.random(in: 1...6)
        rotation += 360

        if randomValue == 1 {
            endTurn()
        } else {

            turnScore += randomValue
        }
    }

    func holdTurn() {

        gameScore += turnScore
        turnScore = 0


        if gameScore >= 100 {
            gameOver = true
        }
    }

    func resetGame() {
        turnScore = 0
        gameScore = 0
        randomValue = 1
        rotation = 0
        gameOver = false
    }
}



struct CustomText: View {
    let text: String
    var body: some View {
        Text(text)
            .font(Font.custom("Marker Felt", size: 36))
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80)
            .font(Font.custom("Marker Felt", size: 24))
            .padding()
            .background(Color.red.opacity(configuration.isPressed ? 0.5 : 1.0))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



struct InstructionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("How to Play Pig")
                    .font(Font.custom("Marker Felt", size: 36))
                    .padding(.bottom)

                Text("On each turn, you can roll the die as many times as you want. Each roll adds the die value to your turn score, unless you roll a 1.")
                Text("If you roll a 1, your turn ends immediately and you lose all points from that turn.")
                Text("If you choose to hold, your turn score is added to your game score, and it becomes the next player's turn.")
                Text("The first player to reach 100 points wins!")
            }
            .font(Font.custom("Marker Felt", size: 20))
            .padding()
        }
        .navigationTitle("Instructions")
    }
}


#Preview {
    ContentView()
}
