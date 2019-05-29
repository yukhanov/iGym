//
//  AuthViewController.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 26/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class AuthViewController: UIViewController, FBSDKLoginButtonDelegate {
  
    

    @IBOutlet weak var emailField: UITextField!
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.text = UserDefaults.standard.value(forKey: "Email") as? String
        if let link = UserDefaults.standard.value(forKey: "Link") as? String {
            self.link = link
          //  signInButton.isEnabled = true
        }
        
        let loginButtonFB = FBSDKLoginButton()
        view.addSubview(loginButtonFB)
        loginButtonFB.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 50)
        
        loginButtonFB.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            print("Logged in with facebook")
            
            FirebaseService.instance.createUser(data: ["displayName": authResult?.user.displayName, "email": authResult?.user.email, "photoURL": authResult?.user.photoURL?.absoluteString ])
            
            
            let trainingVC = TrainingTableViewController()
            trainingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            let trainingNVC = UINavigationController(rootViewController: trainingVC)
            
            let exerciseVC = ExerciseTableViewController()
            exerciseVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            
            let profileVC = ProfileViewController()
            profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
            
            let tabs = UITabBarController()
            tabs.viewControllers = [trainingNVC, exerciseVC, profileVC]
            self.present(tabs, animated: true)
            // ...
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
    @IBAction func signInTapped(_ sender: Any) {
        LocalModel.signIn = "yes"
        
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
      
        if let email = self.emailField.text {
            
                // [START action_code_settings]
                let actionCodeSettings = ActionCodeSettings()
                actionCodeSettings.url = URL(string: "igym-5b1ca.firebaseapp.com")
                // The sign-in operation has to always be completed in the app.
                actionCodeSettings.handleCodeInApp = true
                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
                actionCodeSettings.setAndroidPackageName("com.example.android",
                                                         installIfNotAvailable: false, minimumVersion: "12")
                // [END action_code_settings]
                // [START send_signin_link]
                Auth.auth().sendSignInLink(toEmail:email,
                                           actionCodeSettings: actionCodeSettings) { error in
                                            // [START_EXCLUDE]
                                
                                                // [END_EXCLUDE]
                                                if let error = error {
                                                    self.showMessagePrompt(error.localizedDescription)
                                                    return
                                                }
                                                // The link was successfully sent. Inform the user.
                                                // Save the email locally so you don't need to ask the user for it again
                                                // if they open the link on the same device.
                                                UserDefaults.standard.set(email, forKey: "Email")
                                                self.showMessagePrompt("Check your email for link")
                                                // [START_EXCLUDE]
                                            
                                            // [END_EXCLUDE]
                }
                // [END send_signin_link]
            
        } else {
            self.showMessagePrompt("Email can't be empty")
        }
    }
    
    func showMessagePrompt(_ alertMessage: String) {
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}



