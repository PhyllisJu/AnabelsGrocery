//
//  File.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import Foundation

class Menu {
    var image: String
    var description: String
    var ingredients: [Product]
    
    init(image: String, description: String, ingredients: [Product]) {
        self.image = image
        self.description = description
        self.ingredients = ingredients
    }
}
