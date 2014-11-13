//
//  ViewController.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 11/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dealerArea: UIView!
    @IBOutlet weak var dealerCardsView: UIView!
    @IBOutlet weak var playerMoneyLabel: UILabel!
    @IBOutlet weak var opponentMoneyLabel: UILabel!
    @IBOutlet weak var opponentCardsVIew: UIView!
    @IBOutlet weak var playerArea: UIView!
    @IBOutlet weak var playerCardsView: UIView!
    @IBOutlet weak var opponentArea: UIView!
    
    @IBAction func hitAction(sender: AnyObject) {
        println("[Game] Player Action: 'hit'")
        self.dealer.hit(Singleton.sharedInstance.players[0])
        self.clearView(self.opponentCardsVIew)
        self.drawOpponentCards()
        
        self.stats = self.dealer.getStats()
        self.playerMoneyLabel.text = self.stats["playerMoney"]?.description
        self.drawPlayerCards()
    }
    
    @IBAction func stayAction(sender: AnyObject) {
        println("[Game] Player Action: 'stay'")
        
        self.dealer.opponentPlay()
        self.drawOpponentCards()
        self.dealer.dealerPlay()
        self.stats = self.dealer.getStats()
        self.playerMoneyLabel.text = self.stats["playerMoney"]?.description
        self.opponentMoneyLabel.text = self.stats["opponentMoney"]?.description
        self.drawDealerCards()
        
        self.dealer.newGame()
    }
    
    let dealer = Dealer(numberOfDecks: 3)
    
    var stats = [String: Int] ()
    
    func makeCard(cardImage: String, frameWidth: CGFloat, frameHeight: CGFloat, offsetX: CGFloat, offsetY: CGFloat) -> UIButton {
        var button : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        button.frame = CGRectMake(offsetX, offsetY, frameWidth, frameHeight)
        button.setImage(UIImage(named: cardImage), forState: .Normal)
        
        return button
    }
    
    func clearView(view: UIView) {
        for subview in view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func drawPlayerCards() {
        self.clearView(self.playerCardsView)
        var playerViewWidth = self.playerCardsView.bounds.width
        var playerViewHeight = self.playerCardsView.bounds.height
        
        var cardsFrame = CGRectMake(0, 0, playerViewWidth, playerViewHeight)
        var cardsView = UIView(frame: cardsFrame)
        
        var counter = 0
        for card in Singleton.sharedInstance.players[0].hand.cards {
            var cardImage = "\(card.0.rank)_of_\(card.0.suit)s.png"
            var item = self.makeCard(cardImage, frameWidth: 45, frameHeight: 68, offsetX: CGFloat(counter * 15), offsetY: CGFloat(counter * 10))
            cardsView.addSubview(item)
            counter++
        }
        
        self.playerCardsView.addSubview(cardsView)
    }
    
    func drawOpponentCards() {
        self.clearView(self.opponentCardsVIew)
        var playerViewWidth = self.opponentCardsVIew.bounds.width
        var playerViewHeight = self.opponentCardsVIew.bounds.height
        
        var cardsFrame = CGRectMake(0, 0, playerViewWidth, playerViewHeight)
        var cardsView = UIView(frame: cardsFrame)
        
        var counter = 0
        for card in Singleton.sharedInstance.players[1].hand.cards {
            var cardImage = "\(card.0.rank)_of_\(card.0.suit)s.png"
            var item = self.makeCard(cardImage, frameWidth: 45, frameHeight: 68, offsetX: CGFloat(counter * 15), offsetY: CGFloat(counter * 10))
            cardsView.addSubview(item)
            counter++
        }
        
        self.opponentCardsVIew.addSubview(cardsView)
    }
    
    func drawDealerCards() {
        self.clearView(self.dealerCardsView)
        var dealerViewWidth = self.dealerCardsView.bounds.width
        var dealerViewHeight = self.dealerCardsView.bounds.height
        
        var cardsFrame = CGRectMake(0, 0, CGFloat(45*self.dealer.hand.cards.count), CGFloat(68*self.dealer.hand.cards.count))
        var cardsView = UIView(frame: cardsFrame)
        
        var counter = 0
        for card in self.dealer.hand.cards {
            var cardImage = "\(card.0.rank)_of_\(card.0.suit)s.png"
            var item = self.makeCard(cardImage, frameWidth: 45, frameHeight: 68, offsetX: CGFloat(counter * 15), offsetY: CGFloat(counter * 10))
            cardsView.addSubview(item)
            counter++
        }
        
        self.dealerCardsView.addSubview(cardsView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dealer.deal()
        self.dealer.displayStats()
        self.drawDealerCards()
        self.drawPlayerCards()
        self.drawOpponentCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

