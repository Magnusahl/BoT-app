//
//  NewEntryViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-01-31.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit

class NewEntryViewController: UIViewController {

    
    @IBOutlet weak var addName: UITextField!
    
    
    var playerVC: PlayerListTableViewController?
    var player: Player?
    var entry = PlayerEntry(name: "", amount: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addName.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        entry.name = addName.text!

        player?.add(entry: entry)
        playerVC?.refresh()
        _ = navigationController?.popToRootViewController(animated: true)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
