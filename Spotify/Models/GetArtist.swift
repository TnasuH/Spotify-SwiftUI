// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getArtist = try? newJSONDecoder().decode(GetArtist.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.getArtistTask(with: url) { getArtist, response, error in
//     if let getArtist = getArtist {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - GetArtist
public struct GetArtist: Codable {
    public let externalUrls: ExternalUrls
    public let followers: Followers
    public let genres: [String]
    public let href: String
    public let id: String
    public let images: [Image]
    public let name: String
    public let popularity: Int
    public let type: OwnerType
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

    public init(externalUrls: ExternalUrls, followers: Followers, genres: [String], href: String, id: String, images: [Image], name: String, popularity: Int, type: OwnerType, uri: String) {
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
