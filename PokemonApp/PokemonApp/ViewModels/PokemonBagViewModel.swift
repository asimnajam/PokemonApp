//
//  PokemonBagViewModel.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import SwiftUI
import RealmSwift

class PokemonBagViewModel: ObservableObject {
    @ObservedResults(PokemonModel.self) var pokemons
    private(set) var selectedPokemon: PokemonModel? = nil
    
    func select(pokemon: PokemonModel) {
        selectedPokemon = pokemon
    }
}
