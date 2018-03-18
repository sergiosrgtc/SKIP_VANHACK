//
//  Customer.swift
//  SkipTechChallenge
//
//  Created by Sergio Costa on 17/03/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

struct OrderItem: Codable{
    var id: Int
    var orderId: Int
    var productId: Int
    var product: Product
    var price: Double
    var quantity: Int
    var total: Double
}
