//
//  UnsplashResult.swift
//  URLSession. Decodable
//
//  Created by Авазбек Надырбек уулу on 24.06.25.
//

import Foundation

class UnsplashResult: Decodable {
    let id: String
    let urls: UnsplashResultUrls
}

struct UnsplashResultUrls: Decodable {
    let full: String
    let regular: String
    let small: String
}
