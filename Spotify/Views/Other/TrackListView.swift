//
//  TrackListView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

struct TrackListView: View {
    
    @EnvironmentObject var pm: PlayerManagerViewModel
    
    var tracks: [Track]
    var album: Album?
    
    var body: some View {
        ForEach(tracks, id: \.id) {
            item in
            LazyVStack {
                
                trackRow(track: item)
                    .onTapGesture {
                        guard let _ = item.previewurl else { return }
                        var item = item
                        if(item.album == nil) {
                            item.album = self.album
                        }
                        pm.isPlaying = false
                        pm.currentTrack = item
                        pm.isPlaying = true
                        pm.showLargePlayer = true
                    }
                
                
            }
        }
    }
    
    private func trackRow(track: Track) -> some View {
        let isNotPreview = track.previewurl == nil
        return HStack (alignment: .center) {
            ZStack {
                AsyncImage(url: URL(string: track.album?.images.first?.url ?? (album?.images.first?.url ?? ""))) { image in
                    image.resizable()
                    
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(0)
                if isNotPreview {
                    Color.black
                        .opacity(0.5)
                        .frame(width: 40, height: 40, alignment: .center)
                }
            }
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(Helper.getArtistsName(artists: track.artists ?? []))
                    .font(.subheadline)
                    .lineLimit(1)
            }.foregroundColor(isNotPreview ?
                              Color.primary
                .opacity(0.5) : Color.primary
            )
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(isNotPreview ? .green.opacity(0.5) : .green)
                .padding(.trailing,20)
            Image(systemName: "ellipsis")
                .foregroundColor(isNotPreview ? .primary.opacity(0.5) : .primary)
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(tracks: [])
    }
}
