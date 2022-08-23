// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let followers = try? newJSONDecoder().decode(Followers.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.followersTask(with: url) { followers, response, error in
//     if let followers = followers {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Followers
public struct Followers: Codable {
    public let href: String?
    public let total: Int

    enum CodingKeys: String, CodingKey {
        case href = "href"
        case total = "total"
    }

    public init(href: String?, total: Int) {
        self.href = href
        self.total = total
    }
}
