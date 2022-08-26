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
    
    @Published var currentTrack: Track?
    
    
}
