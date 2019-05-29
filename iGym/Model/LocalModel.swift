//
//  Profile.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 26/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocalModel {
    
    static var id: String? {
        get {
            return UserDefaults.standard.string(forKey: "id")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "id")
        }
    }
    
    static var trainingList: [Training] = []
    static var currentTraining: Training?
    
    static var signIn: String? {
        get {
            return UserDefaults.standard.string(forKey: "signIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "signIn")
        }
    }
//        static var dictionaryExercise: [String: String] = ["id1": "Жим лежа", "id2": "Армейский жим", "id3": "Становая тяга", "id4": "Присед", "id5": "Отведение гантелей назад в наклоне"]
   
//    var name: String
//    var weight: Int
//    var gender: String
//    var age: Int
//    var height: Int
//    init(json: JSON) {
//        <#statements#>
//    }
}
