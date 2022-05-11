//
//  HTTPMethod.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

enum HTTPMethod {
    case get
    case post(data: Data)
    case put(data: Data)
    case delete
    
    var stringValue: String {
        switch self {
        case .get:
            return "Get"
        case .post:
            return "Post"
        case .put:
            return "Put"
        case .delete:
            return "Delete"
        }
    }
}
