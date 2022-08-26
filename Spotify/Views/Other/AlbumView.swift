//
//  AlbumView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

struct AlbumView: View {
    
    var album: Album
    var gradient: LinearGradient = LinearGradient(colors: [Helper.getRandomColor(), Helper.getRandomColor()],
                                                  startPoint: .top, endPoint: .bottom)
    
    @ObservedObject var vm:AlbumDetailViewModel
    
    init(album: Album) {
        self.album = album
        self.vm = AlbumDetailViewModel(albumId: album.id)
    }
    
    var body: some View {
        ZStack {
            gradient
                .ignoresSafeArea()
            Color.black
                .ignoresSafeArea()
                .opacity(0.7)
            ScrollView {
                VStack(alignment: .center) {
                    CoverHeadView(album: album, duration: vm.durationms)
                        .padding(0)
                        .padding(.top,20)
                        .listRowSeparator(.hidden)
                    if let album = vm.album, let tracks = album.tracks,let items = tracks.items {
                        TrackListView(tracks: items, albumUrl: album.images.first?.url)
                        Color.clear ///For the empty space in view
                            .frame(width: 20, height: 150, alignment: .center)
                    }
                    Spacer()
                }
                .padding(.top,50)
                .padding()
            }
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .onAppear {
            vm.fetchData()
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static let externalUrls = ExternalUrls(spotify: "")
    static var previews: some View {
        AlbumView(album: (Album(albumType: "albumType", artists: [Artist(externalUrls: externalUrls, followers: Followers(href: nil, total: 3), genres: ["pop"], href: "", id: "", images: [], name: "asd", popularity: 3, type: "", uri: "")], availableMarkets: ["TR"], externalUrls: externalUrls, href: "", id: "", images: [], name: "", releaseDate: "", releaseDatePrecision: "", totalTracks: 3, type: nil, uri: "", tracks: nil)))
    }
}

