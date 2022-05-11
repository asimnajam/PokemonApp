//
//  PokemonImageViewModel.swift
//  PokemonApp
//
//  Created by Admin on 11/05/2022.
//

import Foundation
import SwiftUI

final class PokemonImageViewModel: ObservableObject {
    @Published var image: UIImage?
    private let urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
        fetchLoadImage()
    }
    
    private func fetchLoadImage() {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    private func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else { return }
        guard let data = data else { return }
        
        DispatchQueue.main.async {
            self.image = UIImage(data: data)
        }
    }
}
