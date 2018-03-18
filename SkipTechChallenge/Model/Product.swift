//
//  Customer.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

struct Product: Codable{
    var id: Int
    var storeId: Int
    var name: String
    var description: String
    var price: Double
}
