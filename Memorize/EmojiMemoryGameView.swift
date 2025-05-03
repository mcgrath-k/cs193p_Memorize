//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kyle McGrath on 12/23/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    
    private let cardAspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4 
    
    var body: some View {
        VStack {
            HStack {
                Text("Theme: \(viewModel.themeName)")
                    .foregroundStyle(viewModel.themeColor)
                    .animation(.default, value: viewModel.themeName)
                Spacer()
                Text("Score: \(viewModel.score)")
                    .animation(.default, value: viewModel.score)
            }
            cards
                .animation(.default, value: viewModel.cards)
                .foregroundColor(viewModel.themeColor)
            HStack {
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
            }
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, cardAspectRatio: cardAspectRatio) { card in
                CardView(card)
                    .padding(spacing)
                    .onTapGesture {
                        viewModel.choose(card)
            }
        }
    }
}




struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
