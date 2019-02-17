//
//  LoginVC.swift
//  RNDM
//
//  Created by Sean Veal on 2/14/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailTxt.text,
            let password = passwordTxt.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                debugPrint("Problem signing in \(error)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func createUserButtonPressed(_ sender: Any) {
    }
    
}
