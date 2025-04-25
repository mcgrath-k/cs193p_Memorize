//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Kyle McGrath on 12/23/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    let emojis: Array<String> = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👺", "😱", "☠️", "🍭"]
    
    
    var body: some View {
        ScrollView{
            cards
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(Color.orange)
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    EmojiMemoryGameView()
}
