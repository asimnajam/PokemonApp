//
//  ContentView.swift
//  PokemonApp
//
//  Created by Admin on 10/05/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var contentViewModel = ContentViewModel(pokemonServices: PokemonAPIServices())
    @State private var isPresentingBagView: Bool = false
    @State private var showToast: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5.0) {
                if !contentViewModel.isEmptyState {
                    HeadingText(title: contentViewModel.pokemon.name)
                    
                    Spacer()
                    
                    PokemonImageView(urlString: contentViewModel.pokemon.imageURL)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                    infoView
                } else {
                    VStack {
                        CapsuleShapedButton(
                            label: contentViewModel.searchPokemonButtonState.title,
                            color: contentViewModel.searchPokemonButtonState.color,
                            action: {
                                contentViewModel.searchPokemon()
                            }
                        ).disabled(!contentViewModel.searchPokemonButtonState.disabled)
                        Text("Please tap search button to see POKEMON")
                            .font(.system(size: 12.0))
                            .fontWeight(.ultraLight)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text(contentViewModel.errorMessage)
                            .font(.system(size: 14.0))
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .padding(.all, 20)
            .navigationTitle("Pokemon App")
            .navigationBarItems(leading: Button(action: {
                self.isPresentingBagView.toggle()
            }, label: {
                Text("Catched Pokemons")
            }))
        }
        .sheet(isPresented: $isPresentingBagView) {
            PokemonBagView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension ContentView {
    var catchPokemon: some View {
        CapsuleShapedButton(label: contentViewModel.catchButtonState.title, color: contentViewModel.catchButtonState.color) {
            contentViewModel.catchPokemon()
            showToast = true
        }.disabled(contentViewModel.catchButtonState.disabled)
    }
    
    var leavePokemon: some View {
        CapsuleShapedButton(label: "Leave It!", color: .red) {
            contentViewModel.leavePokemon()
        }
    }
    
    var bottomButtons: some View {
        HStack(alignment: .bottom, spacing: 10.0) {
            catchPokemon
            leavePokemon
        }
    }
    
    var infoView: some View {
        Group {
            VStack(alignment: .leading, spacing: 5.0) {
                TextView(heading: .weight, value: "\(contentViewModel.pokemon.weight)")
                
                TextView(heading: .height, value: "\(contentViewModel.pokemon.height)")
                
                Spacer()
                
                bottomButtons
            }
        }.frame(maxHeight: .infinity, alignment: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
