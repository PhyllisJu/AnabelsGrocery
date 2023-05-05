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
