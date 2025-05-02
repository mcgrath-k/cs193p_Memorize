//
//  ThemeStore.swift
//  Memorize
//
//  Created by Kyle McGrath on 5/1/25.
//

enum ThemeStore {
    static let all: [Theme] = [
        Theme(name: "Halloween",
              emojiSet: ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👺", "😱", "☠️", "🍭"],
              numberOfPairs: 8,
              colorName: "orange"),
        
        Theme(name: "Winter",
              emojiSet: ["❄️", "⛄️", "🌨️", "🎿", "🏂", "🧤", "🧣", "🎄", "🔔", "🎁", "🛷", "🌬️"],
              numberOfPairs: 8,
              colorName: "iceblue"),
        
        Theme(name: "Summer",
              emojiSet: ["☀️", "😎", "🏖️", "🍉", "🏄‍♂️", "🌴", "🕶️", "🍦", "🩴", "⛱️", "🚤", "🐚"],
              numberOfPairs: 10,
              colorName: "yellow"),
        
        Theme(name: "Space",
              emojiSet: ["🚀", "🪐", "👽", "🌌", "🌠", "🌍", "🛰️", "🌑", "🔭", "🛸", "🌟", "☄️"],
              numberOfPairs: 6,
              colorName: "purple"),
        
        Theme(name: "Sports",
              emojiSet: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🥏", "🏓", "🥊", "🎳", "⛳️"],
              numberOfPairs: 6,
              colorName: "green"),
        
        Theme(name: "Emotions",
              emojiSet: ["😀", "😂", "😭", "😡", "😍", "😱", "😴", "🤔", "😬", "🤯", "😇", "🥳"],
              numberOfPairs: 4,
              colorName: "red")
    ]
    
    static func randomTheme() -> Theme {
        all.randomElement()!
    }
}
