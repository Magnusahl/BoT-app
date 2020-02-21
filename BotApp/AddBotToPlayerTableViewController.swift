//
//  AddBotToPlayerTableViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-19.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class AddBotToPlayerTableViewController: UITableViewController {

    let cellIdentity = "BotCell"
    let penalties = Penalties()
    
    var parentVC: PlayerEntryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readFromBotDB()
    }
    
    func readFromBotDB() {
        guard let currentUser = Auth.auth().currentUser else {
            print("oj bot"); return}
        
        let botRef = Firestore.firestore().collection("users").document(currentUser.uid).collection("bot")
        
        botRef.addSnapshotListener() {
            (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            self.penalties.removeAll()
            for document in documents {
                
                let bot = Penalty(snapshot: document)
                self.penalties.add(entry: bot)
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
        return penalties.count
    }

    //Show the bot name and bot amount in the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath as IndexPath) as! botAmountTableViewCell

        if let entry = penalties.entry(index: indexPath.row) {
            cell.textLabel?.text = entry.botName
            cell.botAmount?.text = String(entry.botAmount)
        }
        return cell
    }
    
   
    
    // MARK: - Navigation

    //save the bot the player choose and dismiss the view back to playerentryVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let b = penalties.entry(index: indexPath.row) {
            parentVC?.applyBot(botEntry: b)
        }
        
        dismiss(animated: true, completion: nil)
    }
    

}
