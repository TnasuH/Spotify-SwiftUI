// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let copyright = try? newJSONDecoder().decode(Copyright.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.copyrightTask(with: url) { copyright, response, error in
//     if let copyright = copyright {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Copyright
public struct Copyright: Codable {
    public let text: String
    public let type: String

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
    }

    public init(text: String, type: String) {
        self.text = text
        self.type = type
    }
}
