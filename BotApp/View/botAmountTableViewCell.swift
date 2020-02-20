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

class botAmountTableViewCell: UITableViewCell {
    

    let cellIdentity = "BotEntryCell"
    
    var bot = Penalties()
    var botEntry: Penelty?
    
    
    @IBOutlet weak var botAmount: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)
                as! botAmountTableViewCell

    //        if let entry = players.entry(index: indexPath.row) {
                cell.botAmount?.text = String(botEntry!.botAmount)
    //            cell.labelAmount?.text = amountLabel.text
            
            return cell
        }

}
