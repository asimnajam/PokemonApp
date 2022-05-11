//
//  PokemonAppApp.swift
//  PokemonApp
//
//  Created by Admin on 10/05/2022.
//

import SwiftUI

@main
struct PokemonAppApp: App {
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    
    init() {
        networkMonitor.start()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(networkMonitor)
        }
    }
}
