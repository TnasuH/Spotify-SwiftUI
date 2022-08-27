//
//  ArtistViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 27.08.2022.
//

import Foundation
import SwiftUI

final class ArtistViewModel: ObservableObject {
    
    @Published var artist: Artist
    @Published var albums: Albums?
    
    let apiCaller = APICaller.shared
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    public func getArtistAlbum() {
        apiCaller.getArtistAlbums(artistId: self.artist.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.albums = model
                case .failure(let model):
                    print("error artist: \(model.localizedDescription)")
                }
            }
        }
    }
}
