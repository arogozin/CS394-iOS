//
//  Card.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 10/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

class Card {
    var rank:String, suit:String, color:String;
    
    init(card_rank:String, card_suit:String, card_color:String) {
        rank = card_rank;
        suit = card_suit;
        color = card_color;
    }
}