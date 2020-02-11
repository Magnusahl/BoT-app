//
//  LabelAmountTableViewCell.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-08.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift


class LabelAmountTableViewCell: UITableViewCell {

    let cellIdentity = "PlayerAmountCell"
//    let bot = Bot()
//    var botAmounts = Firestore.firestore().collection("players").child("amount")
    var players = Players()
    
    
    @IBOutlet weak var labelAmount: UILabel!
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return bot.count
//    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath) as! LabelAmountTableViewCell
        
        if let entry = players.entry(index: indexPath.row) {
            cell.textLabel?.text = String(entry.amount)
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabelAmountTableViewCell
//        
//        let amountLabel = amountlabels[indexPath.row]
//        cell.labelAmount?.text = amountLabel.text
//        
//        return cell
//
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
