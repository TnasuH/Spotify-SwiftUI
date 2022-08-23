//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 30.10.2021.
//

import Foundation

struct LibraryAlbumsResponse: Decodable  {
    let items: [SavedAlbum]
}

struct SavedAlbum: Decodable  {
    let added_at: String
    let album: Album
}
