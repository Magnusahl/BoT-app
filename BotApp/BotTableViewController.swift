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
    let bot = Bot()
    var botentry = BotEntry(botName: "", botAmount: 0, id: "")
    
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
            
            self.bot.removeAll()
            for document in documents {
                
                let bot = BotEntry(snapshot: document)
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
        }
        if bot.entry(index: indexPath.row) != nil {
        cell.botAmount.text = String(botentry.botAmount)
        }
        return cell
    }
    
    
    @IBAction func addBot(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add Bot", message: "Type in a bot name and amount", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Type a bot name:" })
        alert.addTextField(configurationHandler: { textField in textField.placeholder = "Enter the amount:" })
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            
            if let text = alert.textFields?.first?.text {
                guard let currentUser = Auth.auth().currentUser else {return}
                
                let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
                
                self.botentry.botName = text
                
                do {
                    try playersDb.collection("bot").addDocument(from: self.botentry)
                } catch {}
                }
            }))
        self.present(alert, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
