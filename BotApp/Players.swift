//
//  Player.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-29.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

//Store all created players
class Players {
    
    private var entries = [Player]()
    
    var count: Int {
        return entries.count
    }
    
    func add(entry: Player) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> Player? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        return nil
    }
    
    //function to remove cell entries
    func removeAll() {
        entries.removeAll()
    }
    func getSortedEntry(index:Int) -> Player? {
        let sortedArray = self.entries.sorted()
        
        return sortedArray[index]
    }
}
