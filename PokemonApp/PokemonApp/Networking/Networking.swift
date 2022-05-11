//
//  Networking.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

final class Networking: NetworkRequestable {
    func makeReq(client: HTTPClientRequestable, complition: @escaping (Result<Data?, Error>) -> Void) {
        let urlRequest = URLRequest.create(client)
        print("\n>>>>>>>>>>>>>>> URL Request >>>>>>>>>>>>>>>>>>>")
        print(urlRequest.url?.absoluteString ?? "")
        print("--------- URL Request Ends ------------- \n")
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }

            if let response = response as? HTTPURLResponse {
                print("\n<<<<<<<<<<<<<<<<< URL Response <<<<<<<<<<<<<<<<<")
                print("URL: \(urlRequest.url?.absoluteString ?? "")")
                print("Status Code: \(response.statusCode)")
                print("------- URL Response Ends ---------\n")
                switch response.statusCode {
                case 200..<300:
                    complition(.success(data))
                default:
                    complition(.failure(NetworkingError.pageNotFound))
//                    https://pokeapi.co/api/v2/pokemon/963
                }
            }
        }.resume()
    }
}
