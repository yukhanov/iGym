//
//  FirebaseService.swift
//  iGym
//
//  Created by Сергей Юханов on 30/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import Firebase
import SwiftyJSON


class FirebaseService {
    
    
    
    func createUser(data:[String: Any]) {
        if let uid = Auth.auth().currentUser?.uid {
            let childUpdates = ["/Users/\(uid)": data]
            print(data, uid)
            LocalModel.signIn = "ok"
            LocalModel.id = uid
            ref.updateChildValues(childUpdates)
        }
    }
    
    static let instance  = FirebaseService()
    
    private init() {
        
    }
    private var ref: DatabaseReference! {
        return Database.database().reference()
    }
    

    func saveCurrentTraining() {
        if let uid = Auth.auth().currentUser?.uid {
            let jsonData = try! JSONEncoder().encode(LocalModel.trainingList)
            let jsonDictionary = try! JSON(data: jsonData).dictionaryObject
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString + "hello")
            
            let key = ref.child("Users").child(uid).childByAutoId().key!
            //let post = ["uid": "1212121",
//                        "author": "geekbrains",
//                        "title": "less6",
//                        "body": updateText.text!]
            let childUpdates = ["/Users/\(uid)\(key)": jsonDictionary]
//                                "/Tests/user-posts/1212121/\(key)/": post]
           ref.updateChildValues(childUpdates)
            
           // self.ref.child("Users").child(uid).childByAutoId().updateChildValues(childUpdates)
        }
    }
    
    func getLocalUserProfile(id: String, view: TrainingTableViewController) {
        ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let value = snapshot.value as? [String: Any] {
                
        
                view.tableView.reloadData()
                view.alert.dismiss(animated: true, completion: nil)
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}


