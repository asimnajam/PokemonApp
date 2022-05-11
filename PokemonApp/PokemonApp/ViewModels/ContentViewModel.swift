//
//  ContentViewModel.swift
//  PokemonApp
//
//  Created by Admin on 10/05/2022.
//

import Foundation
import SwiftUI

struct ButtonState {
    let color: Color
    let title: String
    let enabled: Bool
    
    static var initial: ButtonState {
        ButtonState(
            color: .green,
            title: "Catch It!",
            enabled: true
        )
    }
    
    static var seacrhPokemon: ButtonState {
        ButtonState(
            color: .indigo,
            title: "Search Pokemon!",
            enabled: true
        )
    }
}
class ContentViewModel: ObservableObject {
    private let pokemonServices: PokemonServices
    @Published private(set) var pokemon: PokemonModel = .empty
    @Published private(set) var internetConnected: Bool = false
    @Published private(set) var catchButtonState: ButtonState = .initial
    @Published private(set) var searchPokemonButtonState: ButtonState = .seacrhPokemon
    
    private(set) var toastMessage: String = ""
    
    var isEmptyState: Bool {
       pokemon.id == 0
    }
    
    init(pokemonServices: PokemonServices) {
        self.pokemonServices = pokemonServices
        
        switch NetworkMonitor.shared.status {
        case .connected:
            internetConnected = true
            searchPokemonButtonState = .seacrhPokemon
        case .disconnected:
            internetConnected = false
            searchPokemonButtonState = ButtonState(color: .gray, title: "No Internet!", enabled: false)
        }
    }
    
    var isPokemonExist: Bool {
        PokemonModel.isContains(pokemon: pokemon)
    }
    
    func catchPokemon() {
        pokemon.date = Date()
        PokemonModel.store(model: pokemon)
        
        toastMessage = "Pokemon saved in bag"
        leavePokemon()
    }
    
    func leavePokemon() {
        pokemon = .empty
    }
    
    func searchPokemon() {
        let id = Int.random(in: 1...1000)
        
        guard internetConnected else {
            pokemon = .empty
            return
        }
        
        pokemonServices.fetchPokemon(by: "\(id)") { [weak self] pokemon in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pokemon = PokemonModel(
                    id: id,
                    name: pokemon.name,
                    weight: pokemon.weight,
                    height: pokemon.height,
                    imageURL: pokemon.sprites?.frontDefault ?? "",
                    order: pokemon.order,
                    date: Date(),
                    baseExperience: pokemon.base_experience,
                    type: pokemon.types.compactMap { $0.type?.name }
                )
                let isPokemonExist = PokemonModel.isContains(pokemon: self.pokemon)
                let color: Color = isPokemonExist ? .gray : .green
                let title: String = isPokemonExist ? "Already Exist" : "Catch It!"
                let isEnabled: Bool = isPokemonExist
                self.catchButtonState = ButtonState(color: color, title: title, enabled: isEnabled)
            }
            
        } failure: { error in
            DispatchQueue.main.async {
                self.pokemon = .empty
            }
        }

    }
}
