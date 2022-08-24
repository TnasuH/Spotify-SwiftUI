//
//  FetchState.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import Foundation

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case noResults
    case error(String)
}
