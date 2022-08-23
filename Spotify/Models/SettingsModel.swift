//
//  SettingsModel.swift
//  Spotify
//
//  Created by Tarık Nasuhoğlu on 18.10.2021.
//

import Foundation

struct Section {
    let title: String
    let option: [Option]
    
}

struct Option {
    let title: String
    let handler: () -> Void
}
