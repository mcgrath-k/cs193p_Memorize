//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kyle McGrath on 3/12/25.
//


// View model is part of the UI, because it is packaging up model,
// it does not create views, but it knows about UI dependent things.

// ViewModel

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    @Published private var theme: Theme
    @Published private var model: MemoryGame<String>

    init() {
        let chosenTheme = ThemeStore.randomTheme()
        self.theme = chosenTheme
        self.model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
    }
    

    var themeColor: Color {
        switch theme.colorName {
        case "orange": return .orange
        case "blue":   return .blue
        case "iceblue":return .cyan
        case "red":    return .red
        case "brown":  return .brown
        case "green":  return .green
        case "indigo": return .indigo
        case "mint":   return .mint
        case "pink":   return .pink
        case "purple": return .purple
        case "teal":   return .teal
        case "yellow": return .yellow
        default:       return .gray
        }
    }
        
        
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        
        let chosenEmojis = theme.emojiSet.shuffled().prefix(theme.numberOfPairs)
        
        var game = MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            Array(chosenEmojis)[pairIndex]
        }
        game.shuffle()
        return game
    }

    
    private func createTheme() -> Theme {
        ThemeStore.randomTheme()
    }
    
    var cards: Array<Card> {
        model.cards
    }
    var themeName: String {
        theme.name
    }
    var score: Int {
        model.score
    }

    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        theme = createTheme()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
