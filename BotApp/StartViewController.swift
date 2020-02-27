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
    
    var teamName = TeamName(teamName: "", id: "")
    
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
        
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Password Confirmation"
//            textField.isSecureTextEntry = true
//        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = NSLocalizedString("Team Name", comment: "")
            textField.keyboardType = .default
        }
        
        let signupAction = UIAlertAction(title: NSLocalizedString("Sign Up", comment: ""), style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
//            let conformPasswordField = alertController.textFields![2]
            
            let teamField = alertController.textFields![2]

//            if let teamField = alertController.textFields?[2].text {
//
//                let teamNameEntry = TeamName(teamName: teamField, id: "")
//
//                guard let currentUser = Auth.auth().currentUser else  { return }
//
//                let playersDb = Firestore.firestore().collection("users").document(currentUser.uid)
//
//                print(self.teamName)
//            }
            
            //SigunUp With Firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if let user = self.auth.currentUser {
                    self.performSegue(withIdentifier: self.segueID, sender: self)
                    
                    //Add displayName = Team Name
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = teamField.text
                    changeRequest.commitChanges { (error) in
                        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
