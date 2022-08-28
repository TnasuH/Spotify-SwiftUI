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
            }
        }
    }
    
    private func trackRow(track: Track) -> some View {
        let isNotPreview = track.previewurl == nil
        return HStack (alignment: .center) {
            HStack {
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
                                  Color.white
                    .opacity(0.5) : Color.white)
            }
            .onTapGesture {
                print("row clicked")
                guard let _ = track.previewurl else { return }
                withAnimation {
                    var item = track
                    if(item.album == nil) {
                        item.album = self.album
                    }
                    pm.isPlaying = false
                    pm.currentTrack = item
                    pm.isPlaying = true
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        pm.showLargePlayer = true
                    }
                }
            }
            
            Spacer()
            Button(action: {print("heart clicked")}) {
                Image(systemName: "heart.fill")
                    .foregroundColor(isNotPreview ? .green.opacity(0.5) : .green)
                    .padding(5)
            }
            
            Menu {
                Button(action: {print("share clicked")}) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
                Button(action: {print("2")}) {
                    Label("Add to playlist", systemImage: "plus.circle")
                }
                Button(action: {print("1")}) {
                    Label("Like", systemImage: "heart")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(isNotPreview ? .white.opacity(0.5) : .white)
                    .padding()
            }
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(tracks: [])
    }
}
