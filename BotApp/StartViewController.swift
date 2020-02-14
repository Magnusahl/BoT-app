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
    
    var teamName = TeamNameEntry(teamName: "", id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        auth = Auth.auth()
        
        if let user = self.auth.currentUser {
            print(user.email)
            do {
                try auth.signOut()
            } catch {
                print("Error signing out")
            }
        }
        
    }
    
    
    @IBAction func signUp(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "Signup", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }
        
        alertController.addTextField { (textField) in
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        }
        
        alertController.addTextField { (textField) in
        textField.placeholder = "Password Confirmation"
        textField.isSecureTextEntry = true
        }
        
        let signupAction = UIAlertAction(title: "Sign Up", style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
            let conformPasswordField = alertController.textFields![2]

            //Perform validation or whatever you do want with the text of textfield

            //SigunUp With Firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { result, error in
                if let user = self.auth.currentUser {
                    self.performSegue(withIdentifier: self.segueID, sender: self)
                } else {
                    print("Error: \(error)")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(signupAction)
        alertController.addAction(cancelAction)

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func logIn(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "Log In", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
        }

        alertController.addTextField { (textField) in
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        }
        
        
        let loginAction = UIAlertAction(title: "Log in", style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]

            //Perform validation or whatever you do want with the text of textfield

            //Login With Firebase
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if let user = self.auth.currentUser {
                    self.performSegue(withIdentifier: self.segueID, sender: self)
                } else {
                    print("Error: \(error)")
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(loginAction)
                alertController.addAction(cancelAction)

                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                
            }
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
