//
//  NetworkLayer.swift
//  URLSession. Decodable
//
//  Created by Авазбек Надырбек уулу on 23.06.25.
//

import Foundation

class NetworkLayer {
    
    let url = "https://api.unsplash.com"
    
    //1 URL
    //2 Request (Method, Post/Get/Put/Patch). body/header
    //3 Send Request
    
    func sendRequest() {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.unsplash.com"
//        urlComponents.path = "/photos/random"
        
         var urlComponetns = URLComponents(string: url)
         urlComponetns?.path = "/photos"
        
         urlComponetns?.queryItems = [
            URLQueryItem(name: "per_page", value: "5"),
//            URLQueryItem(name: "client_id", value: "6wjGtXS4FT_REdmrZgbDvORFarTGz_Gz_5jJackCqEg"),
        ]
        
        guard let reqURL = urlComponetns?.url else { return }
        
        var urlRequest = URLRequest(url: reqURL)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = ["Authorization": "Client-ID 6wjGtXS4FT_REdmrZgbDvORFarTGz_Gz_5jJackCqEg"]
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
//            print(data)
//            
//            print(String(decoding: data, as: UTF8.self))
            
            // data = json -> [UnsplashResult]
            
            do {
                let result = try JSONDecoder().decode([UnsplashResult].self, from: data)
                result.forEach { UnsplashResult in
                    print(UnsplashResult.urls.full)
                }
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}

//Decode - json -> Swift model/struct
//Entcode - Swift model/struct -> JSON

