//
//  FirebaseService.swift
//  iGym
//
//  Created by Сергей Юханов on 30/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import Firebase


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
            self.ref.child("Users").child(uid).childByAutoId().setValue(LocalModel.currentTraining?.date)
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


