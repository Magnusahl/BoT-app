//
//  PlayerEntryViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class PlayerEntryViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var botCountLabel: UILabel!
    
    var playerEntry: PlayerEntry?
    let playersRef = Firestore.firestore().collection("players")
    var amount = 0
    var botCount = 0
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let amount = playerEntry?.amount {
            amountLabel.text = String(amount)
        }
        
        if let botCount = playerEntry?.botCount {
            botCountLabel.text = String(botCount)
        }
        
        nameLabel.text = playerEntry?.name
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addBotWater(_ sender: UIButton) {
        guard var playerEntry = playerEntry else {print("entry nil") ; return}
        
        print("add")
        playerEntry.amount += 10
        
        print("bot")
        playerEntry.botCount += 1
        
       // let botCount = playerEntry.botCount
        botCountLabel.text = String(playerEntry.botCount)
        
        
        do {
            try playersRef.document(playerEntry.id).setData(from: playerEntry)
            amountLabel.text = String(playerEntry.amount)
        } catch {}
        
    }
    
    
    @IBAction func addRedCard(_ sender: UIButton) {
        guard playerEntry != nil else {print("entry nil") ; return}
        
        print("Red")
        playerEntry?.amount += 50
        
        print("RB")
        playerEntry?.botCount += 1
        
        botCountLabel.text = String(playerEntry!.botCount)
        
        
        
//        playerEntry?.amount += 50
//        if let amount = playerEntry?.amount {
//                amountLabel.text = String(amount)
//        }
    }
    
//    func saveData() {
//        do {
//            try playersRef.document(playerEntry.id).setData(from: playerEntry)
//            amountLabel.text = String(playerEntry.amount)
//        } catch {}
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
