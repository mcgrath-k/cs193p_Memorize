//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kyle McGrath on 12/23/23.
//

// View

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    private let cardAspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    private let dealAnimation: Animation = .easeInOut(duration: 0.75)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    
    var body: some View {
        VStack {
            HStack {
                theme
                Spacer()
                score
            }
            cards.foregroundColor(viewModel.themeColor)
            HStack {
                shuffle
                Spacer()
                deck.foregroundColor(viewModel.themeColor)
                Spacer()
                newGame
            }
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var theme: some View {
        Text("Theme: \(viewModel.themeName)")
            .foregroundStyle(viewModel.themeColor)
            .animation(.default, value: viewModel.themeName)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }
    
    private var newGame: some View {
        Button("New Game") {
            withAnimation {
                viewModel.newGame()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, cardAspectRatio: cardAspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ?  0 : 100)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0)}
    }
    
    
    @Namespace private var dealingNamespace
    
    private func choose(_ card: Card) {
        withAnimation(.easeInOut) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / cardAspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    
    private func deal() {
        // deal the cards
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }

    
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    
    }
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
