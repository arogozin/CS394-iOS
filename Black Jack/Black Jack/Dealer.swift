//
//  Dealer.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 11/1/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation

extension Array {
    /*
    func randomItem() -> Int {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        //return self[index]
        return index
    }
    */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

class Dealer {
    var shoe = [Card] ();
    var hand = Hand()
    var lowest: (Int, Player)
    var highest: (Int, Player)
    var roundCount = 0
    
    init(numberOfDecks:Int = 1) {
        var counter:Int = 0;
        while counter < numberOfDecks {
            let deck = Deck();
            
            for card in deck.cards {
                shoe.append(card)
            }
            
            counter++
        }
        println(shoe.count)
        shoe.shuffle()
        
        var playerCount = 0
        while playerCount < Singleton.sharedInstance.playerCount {
            Singleton.sharedInstance.players.append(Player())
            playerCount++
        }
        self.lowest = (0, Singleton.sharedInstance.players.first!)
        self.highest = (0, Singleton.sharedInstance.players.first!)
    }
    
    func gotMoney(player: Player) -> Bool {
        if (player.money < 1) {
            println("Player got no money.")
            return false
        }
        return true
    }
    
    func stillGood(player: Player) -> Bool {
        if (player.hand.count < 22) {
            return true
        }
        return false
    }
    
    func lostBet(player: Player) {
        player.money -= 1
        println("[Result] Lost bet. Now you got \(player.money)")

        self.newGame()
    }
    
    func wonBet(player: Player) {
        player.money += 1
        println("Won bet. Now you got \(player.money)")
    }
    
    func hit(player: Player) -> Bool {
        if (player.hand.count < 22) {
            /*
            var cardIndex = shoe.randomItem()
            var card = shoe[cardIndex]
            shoe.removeAtIndex(cardIndex)
            */
            if (self.shoe.count > 0) {
                var card = self.shoe.removeLast()
                player.hand.takeCard(card)
            }
            
            println("[Action] Proceeding to hit.")
            
            if (stillGood(player)) {
                println("[Confirmation] Successful hit.")
                self.displayStats()
                return true
            }
            else
            {
                lostBet(player)
                return false
            }
        }
        else {
            println("[Warning] Cannot hit. You got way too many cards.")
            return false
        }
    }
    
    func resetHand() {
        self.hand = Hand()
    }
    
    func newGame() {
        if (self.roundCount == 5) {
            self.shoe.shuffle()
            self.roundCount = 0
        }
        else {
            self.roundCount++
        }
        for player in Singleton.sharedInstance.players {
            player.resetHand()
        }
        self.resetHand()

        self.deal()
    }
    
    func dealerPlay() {
        if (Singleton.sharedInstance.players[0].hand.count > 1) {
        for player in Singleton.sharedInstance.players {
            
            self.lowest = (player.hand.count, player)
            
            if (self.highest.0 < player.hand.count) {
                self.highest = (player.hand.count, player)
            }
                
            else {
                self.lowest = (player.hand.count, player)
            }
        }
        
        println("Lowest count: \(self.lowest.0). Highest count: \(self.highest.0)")
        println("Dealer count: \(self.hand.count)")
        
        while(self.hand.count < self.lowest.0 || self.hand.count <= 18) {
            /*
            var cardIndex = shoe.randomItem()
            var card = shoe[cardIndex]
            shoe.removeAtIndex(cardIndex)
            */
            if (self.shoe.count > 0) {
                var card = self.shoe.removeLast()
                self.hand.takeCard(card)
            }
            println("Taking one more card. Dealer count: \(self.hand.count)")
        }
        
        if (self.hand.count < 22) {
            
            if (self.hand.count >= self.lowest.0) {
                self.lostBet(self.lowest.1)
            }
            else {
                self.wonBet(self.lowest.1)
            }
            if (self.hand.count >= self.highest.0) {
                self.lostBet(self.highest.1)
            }
            else {
                self.wonBet(self.highest.1)
            }
        }
        else
        {
            for player in Singleton.sharedInstance.players {
                self.wonBet(player)
            }
        }
        self.newGame()
        }
    }
    
    func opponentPlay(){
        if (Singleton.sharedInstance.players[1].hand.count < 18) {
            if (Singleton.sharedInstance.players[0].hand.count < 18) {
                // hit
                //while (Singleton.sharedInstance.players[1].hand.count <= 22) {
                    self.hit(Singleton.sharedInstance.players[1])
                //}
            }
            else {
                // stay
                if (Singleton.sharedInstance.players[1].hand.count < 17) {
                    self.hit(Singleton.sharedInstance.players[1])
                }
            }
        }
    }
    
    
    func getStats() -> [String: Int] {
        var stats = [String: Int] ()
        
        stats["playerCount"] = Singleton.sharedInstance.players[0].hand.count
        stats["playerMoney"] = Singleton.sharedInstance.players[0].money
        stats["opponentMoney"] = Singleton.sharedInstance.players[1].money
        
        return stats
    }
    
    func displayStats() {
        println("Player Cards: ")
        
        println("[Info] Dealer cards.")
        for card in self.hand.cards {
            println("\(card.0.rank) of \(card.0.suit), count: \(card.1)")
        }
        println("[Info] Dealer count: \(self.hand.count)")
        println("---")
        
        println("[Info] Your cards.")
        for card in Singleton.sharedInstance.players[0].hand.cards {
            println("\(card.0.rank) of \(card.0.suit), count: \(card.1)")
        }
        println("[Info] Your count: \(Singleton.sharedInstance.players[0].hand.count)")
        println("---")
        
        println("[Info] Opponent cards.")
        for card in Singleton.sharedInstance.players[1].hand.cards {
            println("\(card.0.rank) of \(card.0.suit), count: \(card.1)")
        }
        println("[Info] Opponent count: \(Singleton.sharedInstance.players[1].hand.count)")
        println("---")
    }
    
    func deal() {
        var count = 0
        
        while count < 2 {
            /*
            var cardIndex = shoe.randomItem()
            var card = shoe[cardIndex]
            shoe.removeAtIndex(cardIndex)
            */
            if (self.shoe.count > 0) {
                var card = self.shoe.removeLast()
                self.hand.takeCard(card)
            }
            
            println(self.shoe.count)
            
            // one for dealer
            
            // one for others
            for player in Singleton.sharedInstance.players {
                /*
                var cardIndex = shoe.randomItem()
                var card = shoe[cardIndex]
                shoe.removeAtIndex(cardIndex)
                */
                if (self.shoe.count > 0) {
                    var card = self.shoe.removeLast()
                    player.hand.takeCard(card)
                }
            }
            
            count++
        }
    }
}