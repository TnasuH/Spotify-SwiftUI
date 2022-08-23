// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let owner = try? newJSONDecoder().decode(Owner.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.ownerTask(with: url) { owner, response, error in
//     if let owner = owner {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Owner
public struct Owner: Codable {
    public let displayName: String?
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let type: OwnerType
    public let uri: String
    public let name: String?
    public let images: [Image]?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case type = "type"
        case uri = "uri"
        case name = "name"
        case images = "images"
    }

    public init(displayName: String?, externalUrls: ExternalUrls, href: String, id: String, type: OwnerType, uri: String, name: String?, images: [Image]?) {
        self.displayName = displayName
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.type = type
        self.uri = uri
        self.name = name
        self.images = images
    }
}
