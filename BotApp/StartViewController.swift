//
//  StartViewController.swift
//  BotApp
//
//  Created by Magnus Ahlqvist on 2020-02-12.
//  Copyright © 2020 Magnus Ahlqvist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class StartViewController: UIViewController {
    
    var auth: Auth!
    let segueID = "segueLogIn"
    
    @IBOutlet weak var roundedSignUp: UIButton!
    @IBOutlet weak var roundedLogIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedSignUp.layer.cornerRadius = 16
        roundedLogIn.layer.cornerRadius = 16
        
        auth = Auth.auth()
        
        if let user = self.auth.currentUser {
            do {
                try auth.signOut()
            } catch {
                print("Error signing out")
            }
        }
    }
    
    //Sign up the user
    @IBAction func signUp(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: NSLocalizedString("Sign Up", comment: ""), message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Email", comment: "")
            textField.keyboardType = .emailAddress
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Password", comment: "")
            textField.isSecureTextEntry = true
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Group Name", comment: "")
            textField.keyboardType = .default
        }
        
        let signupAction = UIAlertAction(title: NSLocalizedString("Sign Up", comment: ""), style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
            let teamField = alertController.textFields![2]
            
            //SigunUp With Firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if let user = self.auth.currentUser {
                    
                    guard let text = teamField.text?.lowercased().capitalized else {return}
                    self.changeDisplayName(text: text, user: user){
                        self.performSegue(withIdentifier: self.segueID, sender: self)
                    }
                } else {
                    print("Error: \(error)")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(signupAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //function to sign up and teamname
    func changeDisplayName(text:String, user: User, completion:  @escaping ()->()){
        //Add displayName = Group Name
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = text
        changeRequest.commitChanges { (error) in
            completion()
        }
    }
    
    //Log in the user
    @IBAction func logIn(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: NSLocalizedString("Login", comment: ""), message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Email", comment: "")
            textField.keyboardType = .emailAddress
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Password", comment: "")
            textField.isSecureTextEntry = true
        }
        
        let loginAction = UIAlertAction(title: NSLocalizedString("Login", comment: ""), style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
            
            //Login With Firebase
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if let user = self.auth.currentUser {
                    self.performSegue(withIdentifier: self.segueID, sender: self)
                } else {
                    print("Error: \(error)")
                }
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alertController.addAction(loginAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //Sends the user back to start screen
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
    }
}
