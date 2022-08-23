// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albums = try? newJSONDecoder().decode(Albums.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.albumsTask(with: url) { albums, response, error in
//     if let albums = albums {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Albums
public struct Albums: Codable {
    public let href: String
    public let items: [Album]
    public let limit: Int
    public let next: String?
    public let offset: Int
    public let previous: String?
    public let total: Int

    enum CodingKeys: String, CodingKey {
        case href = "href"
        case items = "items"
        case limit = "limit"
        case next = "next"
        case offset = "offset"
        case previous = "previous"
        case total = "total"
    }

    public init(href: String, items: [Album], limit: Int, next: String, offset: Int, previous: String?, total: Int) {
        self.href = href
        self.items = items
        self.limit = limit
        self.next = next
        self.offset = offset
        self.previous = previous
        self.total = total
    }
}
