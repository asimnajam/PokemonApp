//
//  JSONParser.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

final class JSONParser {
    let decoder = JSONDecoder()
    
    func decode<T: Decodable>(data: Data, model: T.Type) -> T? {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
