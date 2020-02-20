//
//  TeamName.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-20.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

class TeamName {
    
    private var entries = [TeamNameEntry]()
    
    var count: Int {
        return entries.count
    }
    
    func add(entry: TeamNameEntry) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> TeamNameEntry? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        return nil
    }
}
