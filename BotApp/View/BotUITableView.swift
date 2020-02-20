//
//  BotUITableView.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-10.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

//See player bot list when you press on a player
class BotUITableView: UITableView {

    let cellIdentity = "BotEntryCell"
    let bot = Penalties()

//    func botRefresh() {
//        tableView.reloadData()
//    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bot.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity, for: indexPath)

        if let entry = bot.entry(index: indexPath.row) {
            cell.textLabel?.text = entry.botName
        }

        return cell
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
