//
//  teamName.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-12.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class TeamName : Codable {
    
    var teamName: String
    var id: String
    
    init(teamName: String, id: String) {
        self.teamName = teamName
        self.id = ""
    }
    
    init(snapshot: QueryDocumentSnapshot) {
        let value = snapshot.data() as [String : Any]
        teamName = value["teamName"] as! String
        id = snapshot.documentID
    }
    
    
}
