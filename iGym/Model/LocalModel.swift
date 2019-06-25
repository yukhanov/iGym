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
    
    static var trainingList: [Training] {
        get {
//            let jsonString = UserDefaults.standard.string(forKey: "trainingList") ?? ""
//            print(jsonString)
//        //    let jsonData: Data = Data(base64Encoded: jsonString)!
//           var json: [Training] = []
////            do {
//                json = try JSONDecoder().decode([Training].self, from: jsonData)
//            } catch (let error) {
//                print(error)
            if let data = UserDefaults.standard.value(forKey:"trainingList") as? Data {
                let json = try? PropertyListDecoder().decode(Array<Training>.self, from: data)
               
                return json!
            } else {
                return []
            }
//            }
            
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"trainingList")
//            let jsonData = try! JSONEncoder().encode(newValue)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            UserDefaults.standard.set(jsonString, forKey: "trainingList")
        }
    }
    static var currentTraining: Training = Training(date: "", exerciseArray: [])
    static var currentTrainingIndex: Int = 0
    
    static var signIn: String? {
        get {
            return UserDefaults.standard.string(forKey: "signIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "signIn")
        }
    }

}
