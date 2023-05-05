//
//  Product.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import Foundation

struct Product: Codable, Equatable {
    var id: Int
    var image: String
    var name: String
    var category: String
    var price: Float
    var description: String
    var selectedNum: Int
    
    init(id: Int, image: String, name: String, category: String, price: Float, description: String, selectedNum: Int) {
        self.id = id
        self.image = image
        self.name = name
        self.category = category
        self.price = price
        self.description = description
        self.selectedNum = selectedNum
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
            return lhs.name == rhs.name
        }
}

struct ProductResponse: Codable {
    var products: [Product]
}
