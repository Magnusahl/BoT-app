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

    var players = Players()
    var playerEntry: PlayerEntry?
    
    
    @IBOutlet weak var amountLabel: UILabel!
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)
            as! LabelAmountTableViewCell

//        if let entry = players.entry(index: indexPath.row) {
            cell.amountLabel?.text = String(playerEntry!.amount)
//            cell.labelAmount?.text = amountLabel.text
        print("amount: \(playerEntry!.amount)")
        return cell
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabelAmountTableViewCell
//
//        let amountLabel = amountlabel[indexPath.row]
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
