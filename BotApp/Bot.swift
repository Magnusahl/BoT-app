//
//  Bot.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-04.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

class Bot {
    
    private var entries = [BotEntry]()
    
    //computed property
    var count: Int {
        return entries.count
    }
    
    //Lägga till player
    func add(entry: BotEntry) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> BotEntry? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        
        return nil
    }
    
    func removeAll() {
        entries.removeAll()
    }
}
