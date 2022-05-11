//
//  ContentViewModel.swift
//  PokemonApp
//
//  Created by Admin on 10/05/2022.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published private(set) var pokemon: PokemonModel = .empty
    private(set) var toastMessage: String = ""
    
    var isEmptyState: Bool {
       pokemon.id == 0
    }
    
    func catchPokemon() {
        toastMessage = "Pokemon saved in bag"
        leavePokemon()
    }
    
    func leavePokemon() {
        pokemon = .empty
    }
    
    func searchPokemon() {
        let id = Int.random(in: 1...1000)
        
        self.pokemon = PokemonModel(id: 1, name: "Pokemon 1", weight: 10, height: 10, imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", order: 1, date: Date(), baseExperience: 1, type: ["Normal"])

    }
}
