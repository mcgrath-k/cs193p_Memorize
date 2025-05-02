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
            HStack {
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
            }.padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, cardAspectRatio: cardAspectRatio) { card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
        }
        .foregroundColor(viewModel.themeColor)
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
