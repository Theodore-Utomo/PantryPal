//
//  Recipe.swift
//  PantryPal
//
//  Created by Theodore Utomo on 11/12/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id = UUID().uuidString
    let title: String
    let ingredients: String
    let servings: String
    let instructions: String
    var favorite = false
    
    enum CodingKeys: CodingKey {
        case title, ingredients, servings, instructions
    }
}
