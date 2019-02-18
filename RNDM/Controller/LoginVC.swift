//
//  LoginVC.swift
//  RNDM
//
//  Created by Sean Veal on 2/14/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginVC: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    

    // Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    @IBOutlet weak var facebookLoginButtton: FBSDKLoginButton!
    
    // Variables
    var loginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        facebookLoginButtton.delegate = self
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
    // Facebook
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            debugPrint("facebook login failed: \(error)")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: result.token.tokenString)
        firebaseLogin(credential)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    @IBAction func customFaceBookTapped(_ sender: Any) {
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if let error = error {
                debugPrint("Could not login with facebook", error)
            } else if result!.isCancelled {
                print("Facebook login was cancelled")
            } else {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current()!.tokenString)
                self.firebaseLogin(credential)
            }
        }
    }
    
    // Google
    @IBAction func googleSignInTapped(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func customGoogleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            } 
        }
    }
    
}
