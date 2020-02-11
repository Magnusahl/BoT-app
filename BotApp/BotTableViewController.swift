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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        bot.add(entry: BotEntry(botName: "Glömt hårsnodd", botAmount: 10))
//        bot.add(entry: BotEntry(botName: "Inte tackat domare/motståndare", botAmount: 20))
        
        readFromBotDB()
    }
    
    func readFromBotDB() {
        let botRef = Firestore.firestore().collection("bot")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)

        if let entry = bot.entry(index: indexPath.row) {
            cell.textLabel?.text = entry.botName
        }

        return cell
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
