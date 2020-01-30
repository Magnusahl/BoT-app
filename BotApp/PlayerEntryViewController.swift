//
//  PlayerEntryViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit

class PlayerEntryViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var playerEntry: PlayerEntry?
    
    var amount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let amount = playerEntry?.amount {
            amountLabel.text = String(amount)
        }
        
        nameLabel.text = playerEntry?.name
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addBotWater(_ sender: UIButton) {
        playerEntry?.amount += 10
            if let amount = playerEntry?.amount {
                amountLabel.text = String(amount)
        }
    }
    
    
    @IBAction func addRedCard(_ sender: UIButton) {
        playerEntry?.amount += 50
            if let amount = playerEntry?.amount {
                amountLabel.text = String(amount)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
