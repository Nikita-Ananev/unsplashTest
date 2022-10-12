//
//  Photo.swift
//  unsplashTest
//
//  Created by Никита Ананьев on 09.10.2022.
//

import Foundation
struct Result: Codable {
    let total: Int
    let results: [Photo]
}
struct Photo: Codable {
    
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let downloads: Int?
    let liked_by_user: Bool
    let location: Location?
    let user: User?
    let urls: PhotoURL
    
}


struct Location: Codable {
    let name: String?
    let city: String?
    let country: String?
}
struct PhotoURL: Codable {
    let regular: String
    let thumb: String
}

struct User: Codable {
    let name: String?
    
}
