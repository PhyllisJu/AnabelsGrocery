//
//  Filter.swift
//  AnabelsGrocery
//
//  Created by Phyllis Ju on 4/28/23.
//

import Foundation

class Filter {
    var name: String
    var selected: Bool
    var id: Int

    init(name: String, selected: Bool, id: Int) {
        self.name = name
        self.selected = selected
        self.id = id
    }
    
    func setSelected() {
        self.selected = !self.selected
    }
}
