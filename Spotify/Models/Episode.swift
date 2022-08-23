//
//  Episode.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 25.10.2021.
//

import Foundation

// MARK: - Episode
public class Episode: Codable {
    public let audioPreviewURL: String
    public let episodeDescription: String
    public let htmlDescription: String
    public let durationMS: Int
    public let explicit: Bool
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let images: [Image]
    public let isExternallyHosted: Bool
    public let isPlayable: Bool
    public let language: String
    public let languages: [String]
    public let name: String
    public let releaseDate: String
    public let releaseDatePrecision: String
    public let resumePoint: ResumePoint
    public let type: String
    public let uri: String
    public let restrictions: Restrictions
    public let show: Show

    enum CodingKeys: String, CodingKey {
        case audioPreviewURL = "audio_preview_url"
        case episodeDescription = "description"
        case htmlDescription = "html_description"
        case durationMS = "duration_ms"
        case explicit = "explicit"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case isExternallyHosted = "is_externally_hosted"
        case isPlayable = "is_playable"
        case language = "language"
        case languages = "languages"
        case name = "name"
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case resumePoint = "resume_point"
        case type = "type"
        case uri = "uri"
        case restrictions = "restrictions"
        case show = "show"
    }

    public init(audioPreviewURL: String, episodeDescription: String, htmlDescription: String, durationMS: Int, explicit: Bool, externalUrls: ExternalUrls, href: String, id: String, images: [Image], isExternallyHosted: Bool, isPlayable: Bool, language: String, languages: [String], name: String, releaseDate: String, releaseDatePrecision: String, resumePoint: ResumePoint, type: String, uri: String, restrictions: Restrictions, show: Show) {
        self.audioPreviewURL = audioPreviewURL
        self.episodeDescription = episodeDescription
        self.htmlDescription = htmlDescription
        self.durationMS = durationMS
        self.explicit = explicit
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.isExternallyHosted = isExternallyHosted
        self.isPlayable = isPlayable
        self.language = language
        self.languages = languages
        self.name = name
        self.releaseDate = releaseDate
        self.releaseDatePrecision = releaseDatePrecision
        self.resumePoint = resumePoint
        self.type = type
        self.uri = uri
        self.restrictions = restrictions
        self.show = show
    }
}


// MARK: - ResumePoint
public class ResumePoint: Codable {
    public let fullyPlayed: Bool
    public let resumePositionMS: Int

    enum CodingKeys: String, CodingKey {
        case fullyPlayed = "fully_played"
        case resumePositionMS = "resume_position_ms"
    }

    public init(fullyPlayed: Bool, resumePositionMS: Int) {
        self.fullyPlayed = fullyPlayed
        self.resumePositionMS = resumePositionMS
    }
}


// MARK: - Show
public class Show: Codable {
    public let availableMarkets: [String]
    public let copyrights: [Copyright]
    public let showDescription: String
    public let htmlDescription: String
    public let explicit: Bool
    public let externalUrls: ExternalUrls
    public let href: String
    public let id: String
    public let images: [Image]
    public let isExternallyHosted: Bool
    public let languages: [String]
    public let mediaType: String
    public let name: String
    public let publisher: String
    public let type: String
    public let uri: String

    enum CodingKeys: String, CodingKey {
        case availableMarkets = "available_markets"
        case copyrights = "copyrights"
        case showDescription = "description"
        case htmlDescription = "html_description"
        case explicit = "explicit"
        case externalUrls = "external_urls"
        case href = "href"
        case id = "id"
        case images = "images"
        case isExternallyHosted = "is_externally_hosted"
        case languages = "languages"
        case mediaType = "media_type"
        case name = "name"
        case publisher = "publisher"
        case type = "type"
        case uri = "uri"
    }

    public init(availableMarkets: [String], copyrights: [Copyright], showDescription: String, htmlDescription: String, explicit: Bool, externalUrls: ExternalUrls, href: String, id: String, images: [Image], isExternallyHosted: Bool, languages: [String], mediaType: String, name: String, publisher: String, type: String, uri: String) {
        self.availableMarkets = availableMarkets
        self.copyrights = copyrights
        self.showDescription = showDescription
        self.htmlDescription = htmlDescription
        self.explicit = explicit
        self.externalUrls = externalUrls
        self.href = href
        self.id = id
        self.images = images
        self.isExternallyHosted = isExternallyHosted
        self.languages = languages
        self.mediaType = mediaType
        self.name = name
        self.publisher = publisher
        self.type = type
        self.uri = uri
    }
}

