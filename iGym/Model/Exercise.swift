//
//  Exercise.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 26/03/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation

struct Exercise: Codable {
    var type: String
    //= ["Жим лежа", "Армейский жим", "Становая тяга", "Присед", "Отведение гантелей назад в наклоне"]
    var count: [Int]
    var weight: [Int]

}
//struct NameExercise {
//    var name: String
////}
//enum TypeExercise {
//    case barbellSquat //присед
//    case barbellBenchPress //жим лежа
//    case bentOverBarbellRow //тяга в наклоне
//    case pullups //подтягивания
//    case sideLateralRaise //подъемы гантель через стороны (на плечи)
//    case sitUp //подъем корпуса на пресс
//    case seatedBarbellMilitaryPress //армейский жим
//    case barbellDeadlift //становая тяга
//}
