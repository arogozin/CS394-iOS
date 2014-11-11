//
//  GameViewController.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 10/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var playerCount: UILabel!
    @IBOutlet weak var deckCount: UILabel!
    
    @IBOutlet weak var dealerCard1_suit: UILabel!
    @IBOutlet weak var dealerCard1_rank: UILabel!

    @IBOutlet weak var dealerCard2_suit: UILabel!
    @IBOutlet weak var dealerCard2_rank: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerCount.text = String(Singleton.sharedInstance.playerCount)
        deckCount.text = String(Singleton.sharedInstance.deckCount)
        
        let dealer = Dealer(numberOfDecks: 3)
        dealer.deal()
        
        dealerCard1_rank.text = dealer.hand.cards[0].rank
        dealerCard1_suit.text = dealer.hand.cards[0].suit
        
        dealerCard2_rank.text = dealer.hand.cards[1].rank
        dealerCard2_suit.text = dealer.hand.cards[1].suit

        for card in dealer.hand.cards {
            println("Color: \(card.color) , Suit: \(card.suit) , Rank: \(card.rank)")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}