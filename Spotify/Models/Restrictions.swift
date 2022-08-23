//
//  Restrictions.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 25.10.2021.
//

import Foundation

public struct Restrictions: Codable {
    public let reason: RestrictionReasonEnum

    enum CodingKeys: String, CodingKey {
        case reason = "reason"
    }

    public init(reason: RestrictionReasonEnum) {
        self.reason = reason
    }
}

public enum RestrictionReasonEnum: String, Codable {
    case market = "market"
    case product = "product"
    case explicit = "explicit"
}
