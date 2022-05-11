//
//  PokemonImageView.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import SwiftUI

struct PokemonImageView: View {
    @ObservedObject var viewModel: PokemonImageViewModel
    private static var defaultImage = UIImage(named: "emptyState")!
    
    init(urlString: String?) {
        viewModel = PokemonImageViewModel(urlString: urlString)
    }
    
    
    var body: some View {
        Image(uiImage: viewModel.image ?? PokemonImageView.defaultImage)
            .resizable()
            .scaledToFit()
    }
}
