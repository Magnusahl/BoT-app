//
//  BotTableViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-04.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class BotTableViewController: UITableViewController {
    
    let cellIdentity = "BotEntryCell"
    let bot = Penalties()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readFromBotDB()
    }
    
    func readFromBotDB() {
        guard let currentUser = Auth.auth().currentUser else {
            print("oj bot"); return}
        
        let botRef = Firestore.firestore().collection("users").document(currentUser.uid).collection("bot").order(by: "botName", descending: false)
        
        botRef.addSnapshotListener() {
            (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            self.bot.removeAll()
            for document in documents {
                
                let bot = Penalty(snapshot: document)
                self.bot.add(entry: bot)
            }
            self.botRefresh()
        }
    }
    
    //Refresh tableview with new entry
    func botRefresh() {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bot.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath as IndexPath) as! botAmountTableViewCell
        
        if let entry = bot.entry(index: indexPath.row) {
            cell.textLabel?.text = entry.botName
            cell.botAmount?.text = String(entry.botAmount)
        }
        
        return cell
    }
    
    //Add bot in tableview
    @IBAction func addBot(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: NSLocalizedString("Add Penalty", comment: ""), message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = NSLocalizedString("Type a penalty name", comment: "") })
        alert.addTextField(configurationHandler: { textField in textField.placeholder = NSLocalizedString("Enter the amount:", comment: "") })
        alert.addAction(UIAlertAction(title: NSLocalizedString("Save", comment: ""), style: .default, handler: { action in
            
            let botentry = Penalty(botName: "", botAmount: 0, id: "")
            
            // set name
            if let text = alert.textFields?.first?.text?.lowercased().capitalized {
                botentry.botName = text
            }
            
            // set botamount
            if let amount = alert.textFields?[1].text {
                if let amount = Int(amount) {
                    botentry.botAmount = amount
                }
            }
            
            guard let currentUser = Auth.auth().currentUser else {return}
            
            let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
            do {
                try playersDb.collection("bot").addDocument(from: botentry)
            } catch {}
        }))
        self.present(alert, animated: true)
    }
    
    //     Delete bot*****
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let penalties = bot.entry(index: indexPath.row)
            
            guard let documentId = penalties?.id else {return}
            
            guard let currentUser = Auth.auth().currentUser else  { return }
            
            let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
            
            playersDb.collection("bot").document(documentId).delete()
        }
    }
}
