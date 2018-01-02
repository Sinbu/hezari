//
//  CardUnitTests.swift
//  CardUnitTests
//
//  Created by Sina Yeganeh on 12/28/17.
//  Copyright © 2017 Sina Yeganeh. All rights reserved.
//

import XCTest

class CardTests: XCTestCase {
    func testSuitAndRank() {
        let card = Card(suit: Suit.Diamond, rank: Rank.Jack, cardLocation: .Library)
        
        XCTAssert(card.suit == Suit.Diamond)
        XCTAssert(card.rank == Rank.Jack)
        XCTAssert(card.cardLocation == CardLocation.Library)
    }
}

class DeckTests: XCTestCase {
    func testEmptyDeck() {
        let deck = Deck()
        XCTAssert(deck.totalNumberOfCardsInDeck == 0)
    }
    
    func testSingleStandardDeck() {
        let deck = Deck.StandardSingleDeck()
        XCTAssert(deck.totalNumberOfCardsInDeck == 52)
    }
    
    func testSingleStandardDeckWithJokers() {
        let deck = Deck.StandardSingleDeck(withJokers: true)
        XCTAssert(deck.totalNumberOfCardsInDeck == 54)
    }
    
    func testShuffleDeck() {
        var deck = Deck.StandardSingleDeck()
        let card = deck.cardsInDeck[0]
        deck.shuffleDeck()
        XCTAssert(card != deck.cardsInDeck[0])
        
    }
    
    func testDrawCard() {
        var deck = Deck.StandardSingleDeck()
        let card = deck.drawCardFromDeck(to: .P1, from:0)
        XCTAssert(card?.cardLocation == .P1)
        let card2 = deck.drawCardFromDeck()
        XCTAssert(card != card2)
    }
}
