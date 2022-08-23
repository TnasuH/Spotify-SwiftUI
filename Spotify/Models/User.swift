// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let empty = try? newJSONDecoder().decode(Empty.self, from: jsonData)

import Foundation

// MARK: - Empty
public struct User: Codable {
    public let message: String?
    public let playlists: Playlists?
    public let country: String?
    public let displayName: String?
    public let email: String?
    public let explicitContent: ExplicitContent?
    public let externalUrls: ExternalUrls?
    public let followers: Followers?
    public let href: String?
    public let id: String
    public let images: [Image]?
    public let product: String?
    public let type: OwnerType?
    public let uri: String?
    public let albums: Albums?
    public let tracks: [Track]?
    public let seeds: [Seed]?

    enum CodingKeys: String, CodingKey {
        case message
        case playlists
        case country
        case displayName
        case email
        case explicitContent
        case externalUrls
        case followers
        case href
        case id
        case images
        case product
        case type
        case uri
        case albums
        case tracks
        case seeds
    }

    public init(message: String?, playlists: Playlists?, country: String?, displayName: String?, email: String?, explicitContent: ExplicitContent?, externalUrls: ExternalUrls?, followers: Followers?, href: String?, id: String, images: [Image]?, product: String?, type: OwnerType?, uri: String?, albums: Albums?, tracks: [Track]?, seeds: [Seed]?) {
        self.message = message
        self.playlists = playlists
        self.country = country
        self.displayName = displayName
        self.email = email
        self.explicitContent = explicitContent
        self.externalUrls = externalUrls
        self.followers = followers
        self.href = href
        self.id = id
        self.images = images
        self.product = product
        self.type = type
        self.uri = uri
        self.albums = albums
        self.tracks = tracks
        self.seeds = seeds
    }
}
