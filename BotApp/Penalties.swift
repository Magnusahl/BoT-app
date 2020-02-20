//
//  Bot.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-04.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

class Penalties {
    
    private var entries = [Penelty]()
    
    //computed property
    var count: Int {
        return entries.count
    }
    
    //Lägga till player
    func add(entry: Penelty) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> Penelty? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        
        return nil
    }
    
    func removeAll() {
        entries.removeAll()
    }
}
