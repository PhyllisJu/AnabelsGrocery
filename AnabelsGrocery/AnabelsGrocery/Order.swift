//
//  Order.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/5.
//

import Foundation
struct Order: Codable {
    var id: Int
    var total_price: Float
    var inventories: [[String:Int]]
    
}


struct OrderItemResponse: Codable {
    var id: Int
    var num_sel: Int
    var inventory_id: Int
}

struct OrderResponse: Codable {
    var time_created: String
    var pick_up_by: String
    var total_price: Float
    var valid: Bool
    var order_items: [OrderItemResponse]
}

