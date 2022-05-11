//
//  URLRequest+Extension.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

extension URLRequest {
    static let base = "https://pokeapi.co/api/v2/"

    
   // static let base = "https://www.api.com"
    static func create(_ client: HTTPClientRequestable) -> URLRequest {
        let url: URL = {
            var urlComp = URLComponents(string: "\(client.path)")!
            urlComp.queryItems?.append(contentsOf: client.query.map { URLQueryItem(name: $0.key, value: $0.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)) })
            return urlComp.url(relativeTo: URL(string: base)!)!
        }()
        
        var req = URLRequest(url: url)
        if let header = client.header {
            for (key, value) in header {
                req.addValue(value, forHTTPHeaderField: key)
            }
        }
        
//        for (key, value) in client.query {
//            req.addValue(value, forHTTPHeaderField: key)
//        }
        
        req.httpMethod = client.method.stringValue
        
        switch client.method {
        case .delete, .get:
            break
        case let .post(data), let .put(data):
            req.httpBody = data
        }
        return req
    }
}
