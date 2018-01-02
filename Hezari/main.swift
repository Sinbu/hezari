//
//  main.swift
//  Hezari
//
//  Created by Sina Yeganeh on 12/28/17.
//  Copyright © 2017 Sina Yeganeh. All rights reserved.
//

import Foundation

print("Game initialized")

class GameLoop {
    
    
    
}

// pseudocode for game (Hokm):
// Randomly select hokm player by dealing cards until an ace appears
// Optional: Second ace is the partner for that player if not predefined
// Partners are facing each other (p1 and p3 are partners, p2 and p4 are partners)
// Hokm gets 5 cards, next player gets 5 cards. Wait until hokm chooses the trump card
// Optional: Can be the middle card's suit of the 5 cards the next player (their partner)
// would have gotten
// p3 and p4 get 5 cards, then each player gets four cards (no cards in deck)
// Game starts:
// Winner of previous trick starts the trick. Hokm starts first on the first trick
// Play goes clockwise until each player has played a card
// Everyone must follow suit if they have that suit
// If you don't have the suit being played, you can play another suit
// Trump cards always beat non-trump cards, and the highest value card wins the trick
// Non-trump suits outside the suit being played have no value
// Ace is the highest card, then K Q J, then numbers (2 is the lowest card value)
// Each player must play a card (no skipping)
// When one team wins 7 tricks, they have won the round and score 1 point
// If the Hokm's team won the round, they continue to be the Hokm (same hokm)
// If the Hokm's team lost the round, the Hokm becomes the next player clockwise
// If the team wins 7 tricks and the opponents have 0 tricks scored, they score 2 points
// If the team wins 7 tricks and the opponents have 0 tricks scored and one of the opponents
// is the Hokm, the winning team wins 3 points.
// If a team scores 7 or more points, they win the game



// State machine: Given the initial deck state, you can easily rollback to any state ideally

// func playFromHandToTable(card,owner)
