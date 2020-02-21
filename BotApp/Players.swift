//
//  Player.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

class Players {
    
    private var entries = [Player]()
    
    //computed property
    var count: Int {
        return entries.count
    }
    
    //Lägga till player
    func add(entry: Player) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> Player? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        return nil
    }
    
    func removeAll() {
        entries.removeAll()
    }    
}
