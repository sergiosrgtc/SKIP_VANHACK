//
//  Customer.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

struct Customer: Codable{
    var id: Int
    var email: String
    var name: String
    var address: String
    var creation: String //($date-time)
    var password: String
}
