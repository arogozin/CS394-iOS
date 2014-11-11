//
//  Player.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 11/1/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

class Player {
    var hand = Hand()
    var money = 100
    
    func resetHand() {
        hand = Hand()
    }
}