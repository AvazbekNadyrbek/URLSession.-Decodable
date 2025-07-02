//
//  NetworkLayerRikiandMorty.swift
//  URLSession. Decodable
//
//  Created by Авазбек Надырбек уулу on 26.06.25.
//

import Foundation

class NetworkLayerRikiandMorty {
    
    enum OutputOption {
        case pages          // print only number-of-pages info
        case names          // print only character names
        case both           // print both (default)
    }
    
    let url = "https://rickandmortyapi.com"
    
    typealias RMResult = Result<RikandMortyModel, Error>

    func sendRequest(page: Int = 1,
                     completion: @escaping (RMResult) -> Void) {
        // Собираем URL правильно
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        
        components.path = "/api/character"
        components.queryItems = [ // this is a key
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {                        // network error
                completion(.failure(error))
                return
            }

            guard
                let http = response as? HTTPURLResponse,
                (200..<300).contains(http.statusCode),
                let data
            else {
                completion(.failure(NSError(domain: "HTTPError", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(RikandMortyModel.self, from: data)
                completion(.success(decoded))     // <-- closure escapes
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}


