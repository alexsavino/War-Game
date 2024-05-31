//
//  ContentView.swift
//  War-Game
//
//  Created by Alexandra Savino on 5/29/24.
//

import SwiftUI
import Combine

// ...defining Card Class...
struct Card: Hashable {
    let title: String
    let emoji: String
}

// ...defining the deck of cards...
var cardList: [Card] = [
    Card(title: "2 of Spades", emoji: "🂢"),
    Card(title: "3 of Spades", emoji: "🂣"),
    Card(title: "4 of Spades", emoji: "🂤"),
    Card(title: "5 of Spades", emoji: "🂥"),
    Card(title: "6 of Spades", emoji: "🂦"),
    Card(title: "7 of Spades", emoji: "🂧"),
    Card(title: "8 of Spades", emoji: "🂨"),
    Card(title: "9 of Spades", emoji: "🂩"),
    Card(title: "10 of Spades", emoji: "🂪"),
    Card(title: "Jack of Spades", emoji: "🂫"),
    Card(title: "Queen of Spades", emoji: "🂭"),
    Card(title: "King of Spades", emoji: "🂮"),
    Card(title: "Ace of Spades", emoji: "🂡"),
    Card(title: "2 of Diamonds", emoji: "🃂"),
    Card(title: "3 of Diamonds", emoji: "🃃"),
    Card(title: "4 of Diamonds", emoji: "🃄"),
    Card(title: "5 of Diamonds", emoji: "🃅"),
    Card(title: "6 of Diamonds", emoji: "🃆"),
    Card(title: "7 of Diamonds", emoji: "🃇"),
    Card(title: "8 of Diamonds", emoji: "🃈"),
    Card(title: "9 of Diamonds", emoji: "🃉"),
    Card(title: "10 of Diamonds", emoji: "🃊"),
    Card(title: "Jack of Diamonds", emoji: "🃋"),
    Card(title: "Queen of Diamonds", emoji: "🃍"),
    Card(title: "King of Diamonds", emoji: "🃎"),
    Card(title: "Ace of Diamonds", emoji: "🃁"),
    Card(title: "2 of Hearts", emoji: "🂲"),
    Card(title: "3 of Hearts", emoji: "🂳"),
    Card(title: "4 of Hearts", emoji: "🂴"),
    Card(title: "5 of Hearts", emoji: "🂵"),
    Card(title: "6 of Hearts", emoji: "🂶"),
    Card(title: "7 of Hearts", emoji: "🂷"),
    Card(title: "8 of Hearts", emoji: "🂸"),
    Card(title: "9 of Hearts", emoji: "🂹"),
    Card(title: "10 of Hearts", emoji: "🂺"),
    Card(title: "Jack of Hearts", emoji: "🂻"),
    Card(title: "Queen of Hearts", emoji: "🂽"),
    Card(title: "King of Hearts", emoji: "🂾"),
    Card(title: "Ace of Hearts", emoji: "🂱"),
    Card(title: "2 of Clubs", emoji: "🃒"),
    Card(title: "3 of Clubs", emoji: "🃓"),
    Card(title: "4 of Clubs", emoji: "🃔"),
    Card(title: "5 of Clubs", emoji: "🃕"),
    Card(title: "6 of Clubs", emoji: "🃖"),
    Card(title: "7 of Clubs", emoji: "🃗"),
    Card(title: "8 of Clubs", emoji: "🃘"),
    Card(title: "9 of Clubs", emoji: "🃙"),
    Card(title: "10 of Clubs", emoji: "🃚"),
    Card(title: "Jack of Clubs", emoji: "🃛"),
    Card(title: "Queen of Clubs", emoji: "🃝"),
    Card(title: "King of Clubs", emoji: "🃞"),
    Card(title: "Ace of Clubs", emoji: "🃑")
]




/* ------------------------------------------------------------------------------------------------------------- */
// ...where the game is set up + carried out...
class GamePlay: ObservableObject {
    static let gamePlay = GamePlay()
    
    @Published var CPUDeck: [Card] = []
    @Published var userDeck: [Card] = []
    @Published var CPUCount: Int = 0
    @Published var userCount: Int = 0
    @Published var currCPUCard: Card = Card(title: "", emoji: "")
    @Published var currUserCard: Card = Card(title: "", emoji: "")
    @Published var finalGameResult: String = ""
    
    func numberfy(cardValue: String) -> Int {
        switch cardValue {
        case "Jack": return 11
        case "Queen": return 12
        case "King": return 13
        case "Ace": return 14
        default: return Int(cardValue)!
        }
    }
    
    private init() {
        var shuffledDeck = cardList
        //shuffledDeck.shuffle()
        
        let halfCardsNum = shuffledDeck.count/2
        
        CPUDeck = Array(shuffledDeck[0..<halfCardsNum])
        CPUCount = CPUDeck.count
        userDeck = Array(shuffledDeck[halfCardsNum..<shuffledDeck.count])
        userCount = userDeck.count
    }

    func updateGame() -> String {
        
        while true {
            
            if CPUDeck.isEmpty && userDeck.isEmpty {
                print("aksdfjnakdsnjfa")
                return "A TIE! Peace prevails another day."
            } else if CPUDeck.isEmpty {
                return "THE COMBOT WINS! Tough luck, I'm afraid."
            } else if userDeck.isEmpty {
                return "YOU WIN! The COMBOT's circuits are fried from defeat!"
            }
            
            currCPUCard = CPUDeck[1]
            currUserCard = userDeck[0]
            
            print(currCPUCard)
            print(currUserCard)
            print()
            
            var currCPUCardValue = numberfy(cardValue: String(currCPUCard.title.split(separator: " ")[0]))
            var currUserCardValue = numberfy(cardValue: String(currUserCard.title.split(separator: " ")[0]))
            
            var cardPile: [Card] = []
            cardPile.append(currCPUCard)
            cardPile.append(currUserCard)
            CPUDeck.removeAll {$0.title == currCPUCard.title && $0.emoji == currCPUCard.emoji}
            userDeck.removeAll {$0.title == currUserCard.title && $0.emoji == currUserCard.emoji}
            
            CPUCount -= 1
            userCount -= 1
            
            if currCPUCardValue == currUserCardValue {
                continue
            }
            else if currCPUCardValue > currUserCardValue {
                CPUDeck += cardPile
                CPUDeck.shuffle()
                CPUDeck = Array(Set(CPUDeck))
                CPUCount += cardPile.count
                cardPile.removeAll()
                break
            } else if currCPUCardValue < currUserCardValue {
                userDeck += cardPile
                userDeck.shuffle()
                userDeck = Array(Set(userDeck))
                userCount += cardPile.count
                cardPile.removeAll()
                break
            }
        }
        return "" //FOR JUST A REGULAR UPDATE
    }
}

/*
 ALSO WE NEED AN ALWAYS AVAILABLE INSTRUCTIONS PAGE
  - jack < queen < king < ace
  - no suit is better than the other... this leads to WAR upon ties
  - cards are inserted back into the winner's deck randomly
struct SettingsView: View {
    var body: some View {
        
    }
}
 */








/* ------------------------------------------------------------------------------------------------------------- */
struct WelcomeView: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // sheild.slash.fill
                    Image(systemName: "scope")
                        .imageScale(.large)
                    Text("Welcome to War")
                        .font(.title)
                        .padding(.top, 4.0)
                    Text("Tap to Begin")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    isActive.toggle()
                }
                .background(
                    NavigationLink(
                        //UsernameView()
                        destination: GameView(),
                        isActive: $isActive,
                        label: {EmptyView()}
                    )
                )
            }
        }
    }
}


/*
struct UsernameView: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            Text("Your Name:")
            TextField("Enter text", username: $username)
                .keyboardType("com.yourcompany.keyboard")
                .padding()
        }
    }
} */

struct GameView: View {
    @ObservedObject private var gamePlay = GamePlay.gamePlay
    @State private var isDragging = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
        
                ZStack {
                    
                    // ...settings...
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width:35, height:35)
                        .position(x:geometry.size.width-35)
                    
                    // ...COMP display info...
                    ZStack {
                        HStack {
                            Image(systemName: "rectangle.stack.fill")
                                .resizable()
                                .frame(width: 55, height: 55)
                            Text("The Combot")
                                .font(.title)
                        }
                        .position(x: geometry.size.width/2, y:80)
                        Text("\(gamePlay.CPUCount ?? 0)")
                            .font(.title)
                            .position(x: geometry.size.width/2-79, y:85)
                            .colorInvert()
                        Text("\(gamePlay.CPUDeck[0].title)")
                            .font(.system(size: 15))
                            .position(x:geometry.size.width/2, y:310)
                        Text("\(gamePlay.CPUDeck[0].emoji)")
                            .font(.system(size: 210))
                            .position(x:geometry.size.width/2, y:190)
                    }
                    
                    Rectangle()
                        .frame(width: geometry.size.width-30, height: 1)
                        .foregroundColor(Color.black)

                    // ...USER display info...
                    ZStack {
                        HStack {
                            Image(systemName: "rectangle.stack.fill")
                                .resizable()
                                .frame(width: 55, height: 55 )
                            Text("nicolas")
                                .font(.title)
                        }
                        .position(x: geometry.size.width/2, y:geometry.size.height-80)
                        Text("\(gamePlay.userCount ?? 0)")
                            .font(.title)
                            // FIX THIS POSITION ITS NAME-DEPENDENT
                            .position(x: geometry.size.width/2-49.5, y:geometry.size.height-80)
                            .colorInvert()
                        Text("\(gamePlay.userDeck[0].title)")
                            .font(.system(size: 15))
                            .position(x:geometry.size.width/2, y:geometry.size.height-313)
                        Text("\(gamePlay.userDeck[0].emoji)")
                            .font(.system(size: 210))
                            .position(x:geometry.size.width/2, y:geometry.size.height-232)
                    }
                }                 
                
                // ...swipe detection...
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.01))
                    .frame(width: 122, height: 167)
                    .position(x: geometry.size.width/2, y: geometry.size.height-212)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                isDragging = true
                            }
                            .onEnded { gesture in
                                if gesture.translation.height < -50 && isDragging {
                                    print("Upwards drag recognized.")
                                    gamePlay.updateGame()
                                }
                                isDragging = false
                            }
                    )
            }
        }
    }
}

/*
struct ResultsView: View {
    var body: some View {
        @ObservedObject private var gamePlay = GamePlay.gamePlay
        
        //let winner, subtitle = finalGameResult.split(separator: "! ")
        Text()
    }
} */
    
    
#Preview {
    GameView()
}
