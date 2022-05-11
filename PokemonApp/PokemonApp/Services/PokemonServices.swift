//
//  PokemonServices.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import Foundation

protocol PokemonServices {
    func fetchPokemon(by id: String, success: @escaping (Pokemon) -> Void, failure: @escaping (Error) -> Void)
}

class PokemonAPIServices: PokemonServices {
    let handler = Handler()
    
    func fetchPokemon(by id: String, success: @escaping (Pokemon) -> Void, failure: @escaping (Error) -> Void) {
        let client = HTTPClient(method: .get, header: nil, query: [:], path: "pokemon/\(id)")
        
        handler.perform(client: client, model: Pokemon.self) { data in
            success(data)
        } failure: { error in
            failure(error)
        }
    }
}
