//
//  PlayerEntry.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation
import Firebase

class PlayerEntry : Codable{
    
    var name: String
    var amount: Int
    var id: String
    var botCount: Int

    init(name: String, amount: Int, id: String, botCount: Int) {
        self.name = name
        self.amount = amount
        self.id = ""
        self.botCount = botCount
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let value = snapshot.data() as [String : Any]
        name = value["name"] as! String
        amount = value["amount"] as! Int
        id = snapshot.documentID
        botCount = value["botCount"] as! Int
    }
}
