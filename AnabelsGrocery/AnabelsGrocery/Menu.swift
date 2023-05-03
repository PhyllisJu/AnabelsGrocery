//
//  File.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import Foundation

class Menu : Codable {
    var image: String
    var name: String
    var description: String
    var ingredients: [Product]
    
    init(image: String, name: String, description: String, ingredients: [Product]) {
        self.image = image
        self.name = name
        self.description = description
        self.ingredients = ingredients
    }
}
