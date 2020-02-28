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

//Show the users amount in the tableview
class LabelAmountTableViewCell: UITableViewCell {
    
    let cellIdentity = "PlayerAmountCell"
    var players = Players()
    var playerEntry: Player?
    
    @IBOutlet weak var amountLabel: UILabel!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)
            as! LabelAmountTableViewCell
        
        cell.amountLabel?.text = String(playerEntry!.amount)
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
