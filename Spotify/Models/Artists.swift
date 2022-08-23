//
//  Artists.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 25.10.2021.
//

import Foundation

// MARK: - Artists
public struct Artists: Codable {
    public let href: String
    public let items: [Artist]
    public let limit: Int
    public let next: String?
    public let offset: Int
    public let previous: String?
    public let total: Int

    enum CodingKeys: String, CodingKey {
        case href
        case items
        case limit
        case next
        case offset
        case previous
        case total
    }

    public init(href: String, items: [Artist], limit: Int, next: String?, offset: Int, previous: String?, total: Int) {
        self.href = href
        self.items = items
        self.limit = limit
        self.next = next
        self.offset = offset
        self.previous = previous
        self.total = total
    }
}
