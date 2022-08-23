//
//  RecommendedView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI

struct RecommendedView: View {
    
    @Binding var recommendedTracks: [Track]
    
    var body: some View {
        VStack(alignment: .leading){
            recommendedTrackTitle
            ScrollView(.horizontal, showsIndicators: false) {
                LazyVStack {
                    ForEach(recommendedTracks, id:\.id) {
                        recommendedTrackCell(track: $0)
                    }
                }
            }
        }
    }
    
    private var recommendedTrackTitle: some View {
        Text("New Released Albums")
            .font(.title)
            .bold()
            .padding(.top,5)
            .padding(.horizontal)
    }
    
    private func recommendedTrackCell(track: Track) -> some View {
        let trackImageUrlString = track.album?.images.first?.url ?? ""
        
        return ZStack{
            Color.gray.opacity(0.2)
            HStack(alignment: .top) {
                
                AsyncImage(url: URL(string: trackImageUrlString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .frame(width: Helper.screenWidth/5.3)
                .padding(.top,10)
                VStack(alignment: .leading, spacing: 7){
                    Text(track.name)
                        .font(.title2)
                        .bold()
                    Spacer()
                    Text(track.artists?.first?.name ?? "")
                        .font(.title3)
                }.padding(.vertical,10)
            }
            .padding(.horizontal, 5)
            .frame(width: Helper.screenWidth, alignment: .leading)
        }
        .frame(height: (Helper.screenWidth/5), alignment: .center)
    }
}

struct RecommendedView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedView(recommendedTracks: .constant([]))
    }
}
