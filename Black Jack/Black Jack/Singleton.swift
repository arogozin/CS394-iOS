//
//  Singleton.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 10/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

private let _SingletonASharedInstance = Singleton()

class Singleton  {
    
    class var sharedInstance : Singleton {
        return _SingletonASharedInstance
    }
    
    var playerCount = 2
    var deckCount = 3
    var players = [Player] ()
}