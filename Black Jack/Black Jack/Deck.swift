//
//  Deck.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 11/1/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

class Deck {
    let totalCards:Int = 52;
    let cards = [Card] ();
    
    let card_ranks = [String] ();
    let card_suits = ["spade", "diamond", "club", "heart"];
    
    init() {
        var count:Int = 2;
        
        while count < 11 {
            card_ranks.append(String(count));
            count++;
        }
        
        card_ranks += ["jack", "queen", "king", "ace"];
        
        for suit in card_suits {
            for rank in card_ranks {
                let card = Card(suit: suit, rank: rank);
                cards.append(card);
            }
        }
    }
}