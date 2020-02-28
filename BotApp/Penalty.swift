//
//  BotEntry.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-04.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation
import Firebase

class Penalty : Codable {
    
    var botName: String
    var botAmount: Int
    var id: String
    
    init(botName: String, botAmount: Int, id: String) {
        self.botName = botName
        self.botAmount = botAmount
        self.id = ""
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let value = snapshot.data() as [String : Any]
        botName = value["botName"] as! String
        botAmount = value["botAmount"] as! Int
        id = snapshot.documentID
    }
}
