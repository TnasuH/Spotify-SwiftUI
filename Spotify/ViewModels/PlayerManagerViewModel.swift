//
//  PlayerManagerViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 26.08.2022.
//

import Foundation
import SwiftUI


final class PlayerManagerViewModel: ObservableObject {
    
    @Published var isPlaying: Bool = false
    @Published var showLargePlayer: Bool = false
    @Published var playerSeekTime: Double = 60
    @Published var currentTrack: Track?
    
    
    func clearPlayer() {
        isPlaying = false
        playerSeekTime = 0
        currentTrack = nil
    }
    
}
