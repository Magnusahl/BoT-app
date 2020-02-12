//
//  PlayerListTableViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class PlayerListTableViewController: UITableViewController {
    
    @IBOutlet weak var addPlayerButton: UIBarButtonItem!
    
    let cellIdentity = "PlayerEntryCell"
    let playerEntrySegueId = "showPlayerEntry"
    let players = Players()
    let newEntrySegueId = "createPlayerEntry"
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readFromDB()
    }
    
    func readFromDB() {
        let playersRef = Firestore.firestore().collection("players")
        
        playersRef.addSnapshotListener() {
            (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            self.players.removeAll()
            for document in documents {
                
                let player = PlayerEntry(snapshot: document)
                self.players.add(entry: player)
            }
            self.refresh()
        }
    }

    func refresh() {
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath as IndexPath) as! LabelAmountTableViewCell

        if let entry = players.entry(index: indexPath.row) {
            cell.textLabel?.text = entry.name
        }
        
        if let entry = players.entry(index: indexPath.row) {
        cell.amountLabel.text = String(entry.amount)
        }

        return cell
    }

    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
        if segue.identifier == playerEntrySegueId {


            guard let destinationVC = segue.destination as? PlayerEntryViewController else {return}
            guard let cell = sender as? UITableViewCell else {return}
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            guard let entry = players.entry(index: indexPath.row) else {return}

            destinationVC.playerEntry = entry
        } else if segue.identifier == newEntrySegueId {
            guard let destinationVC = segue.destination as? NewEntryViewController else {return}
            
//            destinationVC.players = players
//            destinationVC.playerVC = self
        }
    }
}
