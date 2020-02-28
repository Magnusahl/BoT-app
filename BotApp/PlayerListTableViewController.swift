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
    
    @IBOutlet weak var teamName: UILabel!
    
    let auth = Auth.auth()
    
    let cellIdentity = "PlayerEntryCell"
    let playerEntrySegueId = "showPlayerEntry"
    let players = Players()
    let newEntrySegueId = "createPlayerEntry"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateSwitch.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
        readFromDB()
    }
    
    //read from the Firebase database
    func readFromDB() {
        guard let currentUser = Auth.auth().currentUser else  { print("oj"); return }
        
        let playersRef = Firestore.firestore().collection("users").document(currentUser.uid).collection("players").order(by: "name", descending: false)
        
        playersRef.addSnapshotListener() {
            (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            
            self.players.removeAll()
            for document in documents {
                
                let player = Player(snapshot: document)
                self.players.add(entry: player)
            }
            self.refresh()
        }
    }
    
    //Refresh tableview with new entry and Show displayName
    func refresh() {
        tableView.reloadData()
        guard let displayName = auth.currentUser?.displayName else {return}
        teamName.text = displayName
    }
    
    //    Logout the user
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "logoutPlayer", sender: self)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //Switch from showing name to amount in the tableview
    @IBOutlet weak var stateSwitch: UISwitch!
    
    @objc func stateChanged(switchState: UISwitch) {
        guard let currentUser = Auth.auth().currentUser else  { print("oj"); return }
        if switchState.isOn {
            //            teamName.text = "Sort by Name"
            let playersRef1 = Firestore.firestore().collection("users").document(currentUser.uid).collection("players").order(by: "name", descending: false)
            playersRef1.addSnapshotListener() {
                (snapshot, error) in
                guard let documents = snapshot?.documents else {return}
                
                self.players.removeAll()
                for document in documents {
                    
                    let player = Player(snapshot: document)
                    self.players.add(entry: player)
                }
                self.refresh()
            }
            
        } else {
            //            teamName.text = "Sort by Amount"
            let playersRef = Firestore.firestore().collection("users").document(currentUser.uid).collection("players").order(by: "amount", descending: true)
            playersRef.addSnapshotListener() {
                (snapshot, error) in
                guard let documents = snapshot?.documents else {return}
                
                self.players.removeAll()
                for document in documents {
                    
                    let player = Player(snapshot: document)
                    self.players.add(entry: player)
                }
                self.refresh()
            }
        }
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
        
        if stateSwitch.isOn {
            if let entry = players.entry(index: indexPath.row) {
                cell.textLabel?.text = entry.name
                cell.amountLabel?.text = String(entry.amount)
            }
        } else {
            if let sortedEntry = players.getSortedEntry(index: indexPath.row) {
                cell.textLabel?.text = sortedEntry.name
                cell.amountLabel?.text = String(sortedEntry.amount)
            }
        }
        return cell
    }
    
    //Save player name in a UIAlert action *******
    @IBAction func addPlayer(_ sender: UIBarButtonItem) {
        
        let entry = Player(name: "", amount: 0, id: "", botCount: 0)
        
        let alert = UIAlertController(title: NSLocalizedString("Add player", comment: ""), message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = NSLocalizedString("Type in a player name", comment: "") })
        alert.addAction(UIAlertAction(title: NSLocalizedString("Save", comment: ""), style: .default, handler: { action in
            
            if let text = alert.textFields?.first?.text?.lowercased().capitalized {
                guard let currentUser = Auth.auth().currentUser else  { return }
                
                let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
                
                entry.name = text
                
                do {
                    try playersDb.collection("players").addDocument(from: entry)
                } catch {}
            }
        }))
        self.present(alert, animated: true)
    }
    
    //     Delete players*****
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let player = players.entry(index: indexPath.row)
            
            guard let documentId = player?.id else {return}
            
            guard let currentUser = Auth.auth().currentUser else  { return }
            
            let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
            
            playersDb.collection("players").document(documentId).delete()
            
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
            guard segue.destination is PlayerEntryViewController else {return}
        }
    }
}

