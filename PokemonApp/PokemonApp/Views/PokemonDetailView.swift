//
//  PokemonDetailView.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import SwiftUI

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
}

struct PokemonDetailView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6.0) {
            HeadingText(title: viewModel.pokemon.name)
            
            PokemonImageView(urlString: viewModel.pokemon.imageURL)
                .frame(maxWidth: .infinity)
                .aspectRatio(1.0, contentMode: .fit)
            
            TextView(heading: .baseExperience, value: "\(viewModel.pokemon.baseExperience)")
            TextView(heading: .weight, value: "\(viewModel.pokemon.weight)")
            TextView(heading: .height, value: "\(viewModel.pokemon.height)")
            TextView(heading: .dateAdded, value: viewModel.pokemon.formattedDateString)
            TextView(heading: .types, value: viewModel.pokemon.types)
        }.padding(.all, 16.0)
    }
}
