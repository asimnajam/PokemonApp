//
//  PokemonFactory.swift
//  PokemonAppTests
//
//  Created by Admin on 12/05/2022.
//

import Foundation
@testable import PokemonApp

extension Pokemon {
    static var mockPokemon: Pokemon {
        let sprites: Sprites = Sprites(id: 1, frontDefault: "")
        
        let species: Species = Species(name: "ABC", url: "")
        let typeElements: [TypeElement] = [.init(slot: 1, type: species)]
        
        return Pokemon(height: 10, id: 1, name: "Pokemon", order: 1, sprites: sprites, types: typeElements, weight: 10, base_experience: 1)
    }
}
