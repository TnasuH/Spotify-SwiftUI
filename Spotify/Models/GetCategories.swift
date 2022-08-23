//
//  GetCategories.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 24.10.2021.
//

import Foundation

struct GetCategories: Decodable {
    let categories: Category
}

struct Category: Decodable {
    let href: String
    let items: [CategoryItem]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct CategoryItem: Decodable {
    let id: String
    let name: String
    let icons: [Image]
}
