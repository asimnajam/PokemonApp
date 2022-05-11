//
//  PokemonBagCellView.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import SwiftUI

struct PokemonCellView: View {
    let pokemon: PokemonModel
    
    var pokemonSelected: ((PokemonModel) -> Void)
    var body: some View {
        Button {
            pokemonSelected(pokemon)
        } label: {
            HStack {
                PokemonImageView(urlString: pokemon.imageURL)
                    .frame(maxWidth: 50.0)
                    .aspectRatio(1.0, contentMode: .fit)
                VStack {
                    TextView(heading: .name, value: pokemon.name)
                }
            }
        }
    }
}
