//
//  ViewController.swift
//  Black Jack
//
//  Created by Aleksandr Rogozin on 10/9/14.
//  Copyright (c) 2014 Aleksandr Rogozin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label_playerCount: UILabel!
    @IBOutlet weak var label_deckCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label_playerCount.text = String(Singleton.sharedInstance.playerCount)
        label_deckCount.text = String(Singleton.sharedInstance.deckCount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playerCountChanged(sender: UIStepper) {
        label_playerCount.text = Int(sender.value).description
        Singleton.sharedInstance.playerCount = Int(sender.value)
    }
    
    @IBAction func deckCountChanged(sender: UIStepper) {
        label_deckCount.text = Int(sender.value).description
        Singleton.sharedInstance.deckCount = Int(sender.value)
    }
}

