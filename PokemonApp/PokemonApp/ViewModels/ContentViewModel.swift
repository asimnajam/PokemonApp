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
    let disabled: Bool
    
    static var initial: ButtonState {
        ButtonState(
            color: .green,
            title: "Catch It!",
            disabled: true
        )
    }
    
    static var seacrhPokemon: ButtonState {
        ButtonState(
            color: .indigo,
            title: "Search Pokemon!",
            disabled: true
        )
    }
}
class ContentViewModel: ObservableObject {
    private let pokemonServices: PokemonServices
    @Published private(set) var pokemon: PokemonModel = .empty
    @Published private(set) var catchButtonState: ButtonState = .initial
    @Published private(set) var searchPokemonButtonState: ButtonState = .seacrhPokemon
    @Published private(set) var errorMessage: String = ""
    private(set) var toastMessage: String = ""
    
    var isEmptyState: Bool {
       pokemon.id == 0
    }
    
    init(pokemonServices: PokemonServices) {
        self.pokemonServices = pokemonServices
        
        switch NetworkMonitor.shared.status {
        case .connected:
            searchPokemonButtonState = .seacrhPokemon
        case .disconnected:
            searchPokemonButtonState = ButtonState(color: .gray, title: "No Internet!", disabled: false)
        }
    }
    
    var isPokemonExist: Bool {
        PokemonModel.isContains(pokemon: pokemon)
    }
    
    func catchPokemon() {
        pokemon.date = Date()
        PokemonModel.store(model: pokemon)
        
        leavePokemon()
    }
    
    func leavePokemon() {
        pokemon = .empty
    }
    
    func searchPokemon() {
        let id = Int.random(in: 1...1000)
        fetchPokemon(by: id)
    }
    
    private func fetchPokemon(by id: Int) {
        pokemonServices.fetchPokemon(by: "\(id)") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(pokemon):
                DispatchQueue.main.async {
                    self.errorMessage = ""
                    self.pokemon = PokemonModel(
                        id: pokemon.id,
                        name: pokemon.name,
                        weight: pokemon.weight,
                        height: pokemon.height,
                        imageURL: pokemon.sprites?.frontDefault ?? "",
                        order: pokemon.order,
                        date: Date(),
                        baseExperience: pokemon.base_experience,
                        type: pokemon.types.compactMap { $0.type?.name }
                    )
                    
                    let isPokemonExist = self.isPokemonExist
                    let color: Color = isPokemonExist ? .gray : .green
                    let title: String = isPokemonExist ? "Already Exist" : "Catch It!"
                    let isEnabled: Bool = isPokemonExist
                    self.catchButtonState = ButtonState(color: color, title: title, disabled: isEnabled)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    if let error = error as? NetworkingError {
                        self.errorMessage = error.description
                    }
                    self.leavePokemon()
                }
            }
        }
    }
}
