//
//  TrackListView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

struct TrackListView: View {
    
    var tracks: [Track]
    var albumUrl: String?
    var body: some View {
        ForEach(tracks, id: \.id) {
            item in
            LazyVStack {
                trackRow(track: item)
            }
        }
    }
    
    private func trackRow(track: Track) -> some View {
        
        return HStack (alignment: .center) {
            AsyncImage(url: URL(string: track.album?.images.first?.url ?? (albumUrl ?? ""))) { image in
                image.resizable()
                
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40, alignment: .center)
            .cornerRadius(0)
            
            VStack(alignment: .leading) {
                Text(track.name)
                    .font(.headline)
                Text(Helper.getArtistsName(artists: track.artists ?? []))
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundColor(.green)
                .padding(.trailing,20)
            Image(systemName: "ellipsis")
        }
    }
    
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(tracks: [])
    }
}
