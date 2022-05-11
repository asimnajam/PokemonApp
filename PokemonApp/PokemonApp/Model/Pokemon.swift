//
//  Model.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import Foundation
import RealmSwift

// MARK: - Pokemon
struct Pokemon: Codable {
    var height: Int
    var id: Int
    var name: String
    var order: Int
    var sprites: Sprites?
    var types = [TypeElement]()
    
    var weight: Int
    var base_experience: Int
}


// MARK: - Sprites
struct Sprites: Codable {
    var id: Int = 0
    var frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    var slot: Int
    var type: Species?
}

// MARK: - Species
struct Species: Codable {
    var name: String
    var url: String
}
