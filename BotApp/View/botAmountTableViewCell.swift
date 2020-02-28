//
//  botAmountTableViewCell.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-12.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

//Show the users penalty amount in the tableview
class botAmountTableViewCell: UITableViewCell {
    
    let cellIdentity = "BotEntryCell"
    var bot = Penalties()
    var botEntry: Penalty?
    
    @IBOutlet weak var botAmount: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)
            as! botAmountTableViewCell
        
        cell.botAmount?.text = String(botEntry!.botAmount)
        return cell
    }
}
