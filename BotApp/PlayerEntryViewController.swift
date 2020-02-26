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
    
    @IBOutlet weak var roundedAddPenalty: UIButton!
    var playerEntry: Player?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style add penalty button
        roundedAddPenalty.layer.cornerRadius = 28
        
        //Show the total amount of bot placed on the player
        if let amount = playerEntry?.amount {
            amountLabel.text = String(amount)
        }

        //Show the total count of bots
        if let botCount = playerEntry?.botCount {
            botCountLabel.text = String(botCount)
        }
        
        //Show the player name
        nameLabel.text = playerEntry?.name
        
    }
    
    //add bot from the bot list on to the player
    func applyBot(botEntry: Penalty) {
        guard let currentUser = Auth.auth().currentUser else  { return }
        
        guard let playerEntry = playerEntry else {print("entry nil") ; return}
        
        let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
        
        //botAmount + amount on player = new amount
        playerEntry.amount += botEntry.botAmount
        print(playerEntry.amount)
        
        playerEntry.botCount += 1
        print(playerEntry.botCount)
        
        do {
            try playersDb.collection("players").document(playerEntry.id).setData(from: playerEntry)
            amountLabel.text = String(playerEntry.amount)
            botCountLabel.text = String(playerEntry.botCount)
        } catch {}
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
         guard let destinationVC = segue.destination as? AddBotToPlayerTableViewController else {return}
        
        destinationVC.parentVC = self
        
        
     }
    
    
    
    @IBAction func addBotWater(_ sender: UIButton) {
           guard let playerEntry = playerEntry else {print("entry nil") ; return}
           
           print("add")
           playerEntry.amount += 10
           
           // playerEntry.amount += bot.amount
           
           print("bot")
           playerEntry.botCount += 1
           
           botCountLabel.text = String(playerEntry.botCount)
           
           guard let currentUser = Auth.auth().currentUser else  { return }
           
           let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
           
           do {
               try playersDb.collection("players").document(playerEntry.id).setData(from: playerEntry)
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
           

       }
     
}
