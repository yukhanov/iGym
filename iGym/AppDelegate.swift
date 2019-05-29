//
//  AppDelegate.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 26/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if LocalModel.signIn == nil {
            let mainController = AuthViewController() as UIViewController
            
            self.window?.rootViewController = mainController
            self.window?.makeKeyAndVisible()
            
            
        } else {
            // Create UIWindow within the screen boundaries.
            
            
            let trainingVC = TrainingTableViewController()
            trainingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            let trainingNVC = UINavigationController(rootViewController: trainingVC)
            
            let exerciseVC = ExerciseTableViewController()
            exerciseVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            
            let profileVC = ProfileViewController()
            profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
            
            let tabs = UITabBarController()
            tabs.viewControllers = [trainingNVC, exerciseVC, profileVC]
            
            self.window!.rootViewController = tabs
            self.window?.makeKeyAndVisible()
        }
        
        //navigationController.navigationBar.isTranslucent = false
        
        // Override point for customization after application launch.
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
        return handled!
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

