//
//  Training.swift
//  iGym
//
//  Created by Сергей Юханов on 16/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import Foundation

struct Training: Encodable, Decodable {
    var date: String
    var exerciseArray: [Exercise]
}
