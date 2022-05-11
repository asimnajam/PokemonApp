//
//  PokemonBagView.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import SwiftUI

struct PokemonBagView: View {
    @ObservedObject var viewModel = PokemonBagViewModel()
    @State var isPresentingPokemonDetailView: Bool = false
    
    var body: some View {
        List(viewModel.pokemons.sorted(by: { $0.order < $1.order })) { pokemon in
            PokemonCellView(pokemon: pokemon) { selectedPokemon in
                viewModel.select(pokemon: selectedPokemon)
                isPresentingPokemonDetailView.toggle()
            }.sheet(isPresented: $isPresentingPokemonDetailView) {
                if let pokemonn = viewModel.selectedPokemon {
                    let viewModel = PokemonDetailViewModel(pokemon: pokemonn)
                    PokemonDetailView(
                        viewModel: viewModel
                    )
                }
            }
        }
    }
}
