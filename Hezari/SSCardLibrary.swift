//
//  SSCardLibrary.swift
//  Hezari
//
//  Created by Sina Yeganeh on 12/28/17.
//  Copyright © 2017 Sina Yeganeh. All rights reserved.
//
// This file should define different types of card decks and their contents, as
// well as the operations to deal x amount of cards from the top/bottom/randomly,
// shuffling the deck, and viewing what cards are in the deck

import Foundation

// Class for standard 52 card deck
struct Card: Equatable, CustomStringConvertible {
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        if (lhs.rank != rhs.rank) {
            return false
        }
        if (lhs.suit != rhs.suit) {
            return false
        }
        return true
    }
    
    let suit: Suit
    let rank: Rank
    var cardLocation: CardLocation
    
    var description: String {
        return "\(rank) of \(suit.rawValue)s in \(cardLocation)"
    }
}

enum CardLocation: String {
    case P1,P2,P3,P4,Play,Discard,Library
}

enum Suit: String, EnumCollection {
    case Spade
    case Heart
    case Club
    case Diamond
    case Joker
}


enum Rank: Int, EnumCollection {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
    case Joker = 0
}

struct Deck {
    
    var cardsInDeck: [Card]
    
    var totalNumberOfCardsInDeck: Int {
        return cardsInDeck.count
    }
    
    var currentLibrary: [Card] {
        get {
            return cardsInDeck.filter({ $0.cardLocation == .Library })
        }
    }
    
    // Deck operations
    
    mutating func drawCardFromDeck(to: CardLocation = .Play, from: Int = 0) -> Card? {
        // draw only from library
        if (from >= self.currentLibrary.count) {
            return nil
        }
        if let cardIndex = cardsInDeck.index(of: self.currentLibrary[from]) {
            cardsInDeck[cardIndex].cardLocation = to
            let drawnCard = cardsInDeck[cardIndex]
            print("Draw Card - \(drawnCard)")
            return drawnCard
        } else {
            return nil
        }
    }
    
    mutating func drawCardsFromDeck(to: CardLocation = .Play, from: Int = 0, count: Int) -> [Card?] {
        var drawnList:[Card?] = []
        for _ in from ..< count {
            drawnList.append(self.drawCardFromDeck(to: to, from: from))
        }
        return drawnList
    }
    
    mutating func shuffleDeck() {
        // Check extentions below for shuffle methodology (hint: fischer yates)
        // Can add other shuffle methods (bad shuffle, kinda shuffle, etc)
        // This shuffles everything right now
        
        self.cardsInDeck.shuffle()
    }
    
    // Initializers and Static functions
    
    static func StandardSingleDeck(withJokers: Bool = false) -> Deck {
        
        var cards: [Card] = []
        
        for suit in Suit.allValues {
            if suit == .Joker {
                continue
            }
            for rank in Rank.allValues {
                if rank == .Joker {
                    continue
                }
                cards.append(Card(suit: suit, rank: rank, cardLocation: .Library))
            }
        }
        
        if (withJokers) {
            cards.append(Card(suit: .Joker, rank: .Joker, cardLocation: .Library))
            cards.append(Card(suit: .Joker, rank: .Joker, cardLocation: .Library))
        }
        
        return self.init(cards: cards)
    }
    
    init() {
        self.cardsInDeck = []
    }
    
    init(cards: [Card]) {
        self.cardsInDeck = cards
    }
}

// MARK: - Protocols and extensions
// MARK: Protocol and extension to Enums to allow for iteration over all cases

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
    var caseName: String { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
    public var caseName: String {
        return "\(self)"
    }
}

// MARK: Shuffle Method

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            #if os(Linux)
                // TODO: Fix this mess! Should use arc4random or be more thoughtful
                // Also, i think random() needs a +1 to its output, but its crashing right now
                // Note: This is to allow this to work on docker containers
                srandom((UInt32(Date().timeIntervalSince1970)))
                let d: IndexDistance = numericCast(random() % numericCast(unshuffledCount))
            #else
                let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            #endif
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
