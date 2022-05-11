//
//  NetworkRequestable.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

protocol NetworkRequestable {
    var session: URLSession { get }
    func makeReq(client: HTTPClientRequestable, complition: @escaping (Result<Data?, Error>) -> Void)
}

extension NetworkRequestable {
    var session: URLSession {
        URLSession.shared
    }
}
