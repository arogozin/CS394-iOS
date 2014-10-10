//
//  Deck.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 10/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

class Deck {
    let totalCards:Int = 52;
    let cards = [Card] ();
    
    let card_ranks = [String] ();
    let card_suits = ["Spade", "Diamond", "Club", "Heart"];
    
    init() {
        var count:Int = 2;
        
        while count < 11 {
            card_ranks.append(String(count));
            count++;
        }
        
        card_ranks += ["jack", "queen", "king", "ace"];
        
        for suit in card_suits
        {
            let color = (suit == "Spade" || suit == "Club") ? "Black" : "Red";
            for rank in card_ranks
            {
                let card = Card(card_rank: rank, card_suit: suit, card_color: color);
                cards.append(card);
            }
        }
    }
}