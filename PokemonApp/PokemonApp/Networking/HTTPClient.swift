//
//  HTTPClient.swift
//  ImageCaching
//
//  Created by Asim Najam on 2/13/22.
//

import Foundation

struct HTTPClient: HTTPClientRequestable {
    let method: HTTPMethod
    
    let header: [String : String]?
    
    let query: [String : String]
    
    let path: String
}
