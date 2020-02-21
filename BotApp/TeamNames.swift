//
//  TeamName.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-20.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation

class TeamNames {
    
    private var entries = [TeamName]()
    
    var count: Int {
        return entries.count
    }
    
    func add(entry: TeamName) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> TeamName? {
        if index >= 0 && index < entries.count {
            return entries[index]
        }
        return nil
    }
}
