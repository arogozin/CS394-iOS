//
//  Card.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 11/1/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

class Card {
    var suit:String, rank:String
    
    init(suit:String, rank:String) {
        self.suit = suit
        self.rank = rank
    }
}