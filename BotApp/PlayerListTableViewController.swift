//
//  PlayerListTableViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit

class PlayerListTableViewController: UITableViewController {

    
    let cellIdentity = "PlayerEntryCell"
    let playerEntrySegueId = "showPlayerEntry"
    let player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player.add(entry: PlayerEntry(name: "Anders", amount: 0))
        player.add(entry: PlayerEntry(name: "Nils", amount: 250))
        player.add(entry: PlayerEntry(name: "Johan", amount: 125))
        player.add(entry: PlayerEntry(name: "Kevin", amount: 50))
        player.add(entry: PlayerEntry(name: "Sebastian", amount: 70))
        player.add(entry: PlayerEntry(name: "Ludvig", amount: 90))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return player.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)

        if let entry = player.entry(index: indexPath.row) {
            cell.textLabel?.text = entry.name
        }

        return cell
    }
    

    
    @IBAction func addBotButton(_ sender: UIButton) {
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
        if segue.identifier == playerEntrySegueId {

            
            guard let destinationVC = segue.destination as? PlayerEntryViewController else {return}
            guard let cell = sender as? UITableViewCell else {return}
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            guard let entry = player.entry(index: indexPath.row) else {return}

            destinationVC.playerEntry = entry
        }
    }
}
