//
//  HTTPClientRequestable.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

protocol HTTPClientRequestable {
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var query: [String: String] { get }
    var path: String { get }
}
