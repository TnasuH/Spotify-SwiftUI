//
//  PlaylistView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 25.08.2022.
//

import SwiftUI

struct PlaylistView: View {
    
    var playlist: PlaylistsItem
    //var loadedAlbum: GetAlbums?
    var gradient: LinearGradient = LinearGradient(colors: [Helper.getRandomColor(), Helper.getRandomColor()],
                                                  startPoint: .top, endPoint: .bottom)
    
    @StateObject var vm:PlaylistViewModel = PlaylistViewModel()
    
    init(playlist: PlaylistsItem) {
        self.playlist = playlist
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
                    coverHeadView
                        .padding(0)
                        .padding(.top,20)
                        .listRowSeparator(.hidden)
                        if let items = vm.detail?.tracks.items, let tracks = items.compactMap {$0.track} {
                                TrackListView(tracks: tracks)
                        }
                    Color.clear
                        .frame(width: 20, height: 150, alignment: .center)
                    
                    Spacer()
                }
                .padding(.top,50)
                .padding()
            }
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .onAppear {
            vm.getPlaylist(id: playlist.id)
        }
        
    }
    
    private var coverHeadView: some View {
        
        VStack{
            AsyncImage(url: URL(string: vm.detail?.images.first?.url ?? "")) { image in
                image.resizable()
                
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: Helper.screenWidth*0.7, height: Helper.screenWidth*0.7, alignment: .center)
            .cornerRadius(0)
            .padding(.bottom,10)
            
            HStack (alignment: .top ){
                VStack(alignment: .leading, spacing:5){
                    Text(playlist.itemDescription)
                        .font(.footnote)
                    Text(playlist.name)
                        .font(.headline)
                    Text(playlist.owner.displayName ?? "")
                        .font(.subheadline)
                    if let detail = vm.detail {
                        HStack {
                            Text("\(detail.followers.total ?? 0) followers")
                                .font(.subheadline)
                            if (vm.durationms != nil) {
                                Text(vm.durationToString)
                            }
                        }
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("")
                                .font(.footnote)
                            HStack (spacing:20){
                                Image(systemName: "heart")
                                Image(systemName: "arrow.down.circle")
                                Image(systemName: "ellipsis")
                                
                            }.font(.title2)
                        }
                        Spacer()
                        ZStack{
                            Image(systemName: "play.circle.fill")
                                .font(.system(size:38))
                                .foregroundColor(.green)
                            Image(systemName: "shuffle.circle.fill")
                                .font(.subheadline)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.green, Color(uiColor: .darkGray))
                                .padding(.top,30)
                                .padding(.leading,23)
                        }
                        .padding(.trailing,5)
                    }
                }
                .padding(.leading,10)
            }
        }
        
    }
    
}

struct PlaylistView_Previews: PreviewProvider {
    static var ex = ExternalUrls(spotify: "")
    static var previews: some View {
        PlaylistView(playlist: PlaylistsItem(collaborative: false, itemDescription: "desc", externalUrls: ex , href: "", id: "", images: [], name: "", owner: Owner(displayName: "", externalUrls: ex, href: "", id: "", type: OwnerType.artist, uri: "", name: "", images: []), primaryColor: "", itemPublic: true, snapshotid: "", tracks: Followers(href: "", total: 4), type: GetPlaylistsType.playlist, uri: ""))
    }
}



