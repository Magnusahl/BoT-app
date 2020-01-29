//
//  PlayerEntry.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

struct PlayerEntry {
    
    var name: String
    var amount: Int
    //var date: Int
    
    init(name: String, amount: Int) {
        self.name = name
        self.amount = amount
        //self.date = date
    }
    
}
