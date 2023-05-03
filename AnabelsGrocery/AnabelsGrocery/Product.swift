//
//  Product.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import Foundation

class Product: Codable {
    var image: String
    var name: String
    var category: String
    var price: Float
    var inventory: Int
    var description: String
    var selectedNum: Int
    
    init(image: String, name: String, category: String, price: Float, inventory: Int, description: String, selectedNum: Int) {
        self.image = image
        self.name = name
        self.category = category
        self.price = price
        self.inventory = inventory
        self.description = description
        self.selectedNum = selectedNum
    }
}
