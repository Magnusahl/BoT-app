//
//  NewBotEntryViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-04.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


class NewBotEntryViewController: UIViewController {

    
    @IBOutlet weak var addBot: UITextField!
    @IBOutlet weak var addAmountBot: UITextField!
    
    var botVC: BotTableViewController?
    var bot: Bot?
    var botentry = BotEntry(botName: "", botAmount: 0, id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBot.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBot(_ sender: UIBarButtonItem) {
        botentry.botName = addBot.text!
        addAmountBot.text = String(botentry.botAmount)
        
        let playersDb = Firestore.firestore()
                
        do {
            try playersDb.collection("bot").addDocument(from: botentry)
        } catch {}
        
        _ = navigationController?.popViewController(animated: true)
    }

}
