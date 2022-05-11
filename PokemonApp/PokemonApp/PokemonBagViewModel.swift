//
//  PokemonBagViewModel.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import SwiftUI

class PokemonBagViewModel: ObservableObject {
    var pokemons: [PokemonModel] = [
        PokemonModel(id: 1, name: "Pokemon 1", weight: 10, height: 10, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", order: 1, date: Date(), baseExperience: 1, type: ["Normal"]),
        PokemonModel(id: 2, name: "Pokemon 2", weight: 10, height: 10, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png", order: 2, date: Date(), baseExperience: 2, type: ["Fire"]),
        PokemonModel(id: 3, name: "Pokemon 3", weight: 10, height: 10, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png", order: 3, date: Date(), baseExperience: 3, type: ["Fire", "Normal"])
    ]
    private(set) var selectedPokemon: PokemonModel? = nil
    
    func select(pokemon: PokemonModel) {
        selectedPokemon = pokemon
    }
}
