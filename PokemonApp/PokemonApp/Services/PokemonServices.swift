//
//  PokemonServices.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import Foundation

protocol PokemonServices {
    func fetchPokemon(by id: String, compilation: @escaping (Result<Pokemon, Error>) -> Void)
}

class PokemonAPIServices: PokemonServices {
    private let handler = Handler()
    
    func fetchPokemon(by id: String, compilation: @escaping (Result<Pokemon, Error>) -> Void) {
        let client = HTTPClient(method: .get, header: nil, query: [:], path: "pokemon/\(id)")
        
        handler.perform(client: client, model: Pokemon.self) { data in
            compilation(.success(data))
        } failure: { error in
            compilation(.failure(error))
        }
    }
}
