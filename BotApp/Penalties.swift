//
//  Bot.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-04.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

//Store all created penalties
class Penalties {
    
    private var entries = [Penalty]()
    
    var count: Int {
        return entries.count
    }
    
    func add(entry: Penalty) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> Penalty? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        return nil
    }
    
    func removeAll() {
        entries.removeAll()
    }
}
