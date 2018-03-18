//
//  Customer.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

class Order: Codable{
    static let sharedInstance = Order()

    var id: Int?
    var customerId: Int?
    var storeId: Int?
    var deliveryAddress: String?
    var contact: String?
    var date: String? //($date-time)
    var lastUpdate: String? //($date-time)
    var status: String?
    var total: Double?
    var orderItems: [OrderItem]?
}
