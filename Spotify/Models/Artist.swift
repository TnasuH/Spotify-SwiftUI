// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let artist = try? newJSONDecoder().decode(Artist.self, from: jsonData)

import Foundation

// MARK: - Artist
public class Artist: Codable {
    public let externalUrls: ExternalUrls
    public let followers: Followers?
    public let genres: [String]?
    public let href: String
    public let id: String
    public let images: [ImageModel]?
    public let name: String
    public let popularity: Int?
    public let type: String
    public let uri: String

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers = "followers"
        case genres = "genres"
        case href = "href"
        case id = "id"
        case images = "images"
        case name = "name"
        case popularity = "popularity"
        case type = "type"
        case uri = "uri"
    }

    public init(externalUrls: ExternalUrls, followers: Followers, genres: [String], href: String, id: String, images: [ImageModel], name: String, popularity: Int, type: String, uri: String) {
        self.externalUrls = externalUrls
        self.followers = followers
        self.genres = genres
        self.href = href
        self.id = id
        self.images = images
        self.name = name
        self.popularity = popularity
        self.type = type
        self.uri = uri
    }
}
