//
//  UnsplashNetworkController.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 09.10.2022.
//

import Foundation
import UIKit

struct UnsplashApiService {
    
    static var shared = UnsplashApiService()
    
    private let token = "4HS0NeVIXbnKDr7ak-aqxrFd5HCI-3EsG4HDD9fTGUk"
    private let apiUrl = "https://api.unsplash.com/"
    
    private init() {}
    
    
    func getRandomPhotos(completion: @escaping(Any?) -> ()) {
        let url = URL(string: apiUrl + "photos/random?count=50")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        sendRequest(request: request, typeOf: [Photo].self, completion: completion)
    }
    func getSearchingPhotos(text: String, completion: @escaping(Any?) -> ()) {
        let url = URL(string: apiUrl + "search/photos?query=\(text)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        print(request.description)
        sendRequest(request: request, typeOf: Result.self, completion: completion)
    }
    
    
    private func sendRequest(request: URLRequest, typeOf: Codable.Type, completion: @escaping(Any?) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                completion(nil)
                return }
            do {
                let result = try JSONDecoder().decode(typeOf, from: data)
                print(result)
                completion(result as Any)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
