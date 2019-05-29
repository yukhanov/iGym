//
//  ProfileViewController.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 02/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ProfileViewController: UIViewController, FBSDKLoginButtonDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButtonFB = FBSDKLoginButton()
        view.addSubview(loginButtonFB)
        loginButtonFB.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 50)
        
        loginButtonFB.delegate = self
        // Do any additional setup after loading the view.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                // ...
                return
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let authVC = AuthViewController()
            show(authVC, sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
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
