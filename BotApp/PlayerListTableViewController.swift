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
    
    //Refresh tableview with new entry
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
    
    

    //Save player name in a UIAlert action *******
    @IBAction func addPlayer(_ sender: UIBarButtonItem) {
    
        let entry = PlayerEntry(name: "", amount: 0, id: "", botCount: 0)
        let alert = UIAlertController(title: "Add player", message: "Type in a player name", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Type a player name:" })
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            
            if (alert.textFields?.first?.text) != nil {
                let playersDb = Firestore.firestore()
                        
                do {
                    try playersDb.collection("players").addDocument(from: entry)
                } catch {}
                }
        }))
        self.present(alert, animated: true)
    }
    
    // Delete players*****
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let state = name[indexPath.row]
//            players.remove(at: indexPath.row)
//
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//            Firestore.firestore().collection().child("players").child(name[indexPath.row]).removeValue()
//            name.remove(at: indexPath.row)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
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
