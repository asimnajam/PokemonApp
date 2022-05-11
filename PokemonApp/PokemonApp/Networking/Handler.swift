//
//  Handler.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

enum NetworkingError: Error {
    case errorParsingJSON
    case pageNotFound
    case noInternet
    
    var description: String {
        switch self {
        case .noInternet:
            return "Please Check Internet Connection"
        case .pageNotFound:
            return "No Pokemon Found"
        case .errorParsingJSON:
            return "Error Parsing Response"
        }
    }
}

final class Handler {
    let networking: NetworkRequestable
    let jsonParser: JSONParser = JSONParser()
    
    init(networking: NetworkRequestable = Networking()) {
        self.networking = networking
    }
    
    func perform<T: Decodable>(client: HTTPClientRequestable, model: T.Type, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        if NetworkMonitor.shared.status == .disconnected {
            failure(NetworkingError.noInternet)
            return
        }
        networking.makeReq(client: client) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard let parsedJson = self.jsonParser.decode(data: data!, model: T.self) else {
                    assertionFailure("Failed to Parse JSON")
                    failure(NetworkingError.errorParsingJSON)
                    return
                }
                success(parsedJson)
            case let .failure(error):
                failure(error)
            }
        }
    }
}
