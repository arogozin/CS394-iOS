//
//  Dealer.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 10/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

extension Array {
    func randomItem() -> Int {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        //return self[index]
        return index
    }
}

class Dealer {
    var shoe = [Card] ();
    var hand = Hand()
    
    init(numberOfDecks:Int = 1) {
        var counter:Int = 0;
        while counter < numberOfDecks {
            let deck = Deck();
            
            for card in deck.cards {
                shoe.append(card)
            }
            
            counter++
        }
        
        var playerCount = 0
        while playerCount < Singleton.sharedInstance.playerCount {
            Singleton.sharedInstance.players.append(Player())
            playerCount++
        }
    }
    
    func deal() {
        var count = 0
        while count < 2 {
            var cardIndex = shoe.randomItem()
            hand.cards.append(shoe[cardIndex])
            shoe.removeAtIndex(cardIndex)
            
            for player in Singleton.sharedInstance.players {
                cardIndex = shoe.randomItem()
                player.hand.cards.append(shoe[cardIndex])
                shoe.removeAtIndex(cardIndex)
            }
            println(shoe.count)
            count++
        }
    }
}