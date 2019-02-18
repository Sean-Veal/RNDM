//
//  AppDelegate.swift
//  RNDM
//
//  Created by Sean Veal on 2/6/19.
//  Copyright © 2019 Sean Veal. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //Google
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        //Facebook
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            debugPrint("Could not login with google: \(error.localizedDescription)")
        } else {
            guard let controller = GIDSignIn.sharedInstance()?.uiDelegate as? LoginVC else {return}
            guard let authentication = user.authentication else {return}
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            controller.firebaseLogin(credential)
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let returnGoogle = GIDSignIn.sharedInstance()?.handle(url, sourceApplication:
            options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation:
            options[UIApplication.OpenURLOptionsKey.annotation]) ?? false
        
        let returnFB = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, options: options) ?? false
        
        return returnGoogle || returnFB
    }


}

