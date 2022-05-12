//
//  MockPokemonServices.swift
//  PokemonAppTests
//
//  Created by Admin on 12/05/2022.
//

import Foundation
@testable import PokemonApp

class MockPokemonServices: PokemonServices {
    var result: Result<Pokemon, Error> = .success(.mockPokemon)
    
    func fetchPokemon(by id: String, compilation: @escaping (Result<Pokemon, Error>) -> Void) {
        compilation(result)
    }
}
