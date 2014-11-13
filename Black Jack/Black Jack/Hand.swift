//
//  Hand.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 11/1/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

class Hand {
    var cards = [(Card, Int)] ()
    var count = 0
    
    
    func takeCard(taken_card:Card) {
        var card_count = determineCardCount(taken_card)
        self.count += card_count
        
        var card = (taken_card, card_count)
        self.cards.append(card)
        
        println("Card taken: \(taken_card.rank) of \(taken_card.suit)")
    }
    
    func determineCardCount(taken_card:Card) -> Int {
        var card_count = 0
        switch (taken_card.rank) {
        case "2": card_count = 2
        case "3": card_count = 3
        case "4": card_count = 4
        case "5": card_count = 5
        case "6": card_count = 6
        case "7": card_count = 7
        case "8": card_count = 8
        case "9": card_count = 9
        case "10", "jack", "king", "queen": card_count = 10
        case "ace": if(self.count < 11) {
            card_count = 11
            println("Using 11 for ace")
        }
        else {
            card_count = 1
            println("Using 1 for ace")
            }
        default: 0
        }
        
        return card_count
    }
}