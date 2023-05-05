//
//  File.swift
//  AnabelsGrocery
//
//  Created by 张彦哲 on 2023/5/3.
//

import Foundation

class Menu : Codable {
    var id: Int
    var image: String // image url
    var name: String
    var description: String
    var inventories: [Product]
    
    init(id: Int, image: String, name: String, description: String, inventories: [Product]) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.inventories = inventories
    }
}
