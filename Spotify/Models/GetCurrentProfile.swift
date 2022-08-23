// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getCurrentProfile = try? newJSONDecoder().decode(GetCurrentProfile.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.getCurrentProfileTask(with: url) { getCurrentProfile, response, error in
//     if let getCurrentProfile = getCurrentProfile {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - GetCurrentProfile
public struct GetCurrentProfile: Codable {
    public let country: String
    public let displayName: String
    public let email: String
    public let explicitContent: ExplicitContent
    public let externalUrls: ExternalUrls
    public let followers: Followers
    public let href: String
    public let id: String
    public let images: [Image]
    public let product: String
    public let type: OwnerType
    public let uri: String

    enum CodingKeys: String, CodingKey {
        case country = "country"
        case displayName = "display_name"
        case email = "email"
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers = "followers"
        case href = "href"
        case id = "id"
        case images = "images"
        case product = "product"
        case type = "type"
        case uri = "uri"
    }

    public init(country: String, displayName: String, email: String, explicitContent: ExplicitContent, externalUrls: ExternalUrls, followers: Followers, href: String, id: String, images: [Image], product: String, type: OwnerType, uri: String) {
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
    }
}
