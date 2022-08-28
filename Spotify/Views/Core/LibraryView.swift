//
//  LibraryView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 28.08.2022.
//

import SwiftUI

struct LibraryView: View {
    @State var showAlbum: Bool = false
    
    @ObservedObject var plistVm: PlaylistViewModel = PlaylistViewModel()
    
    @ObservedObject var albumVm: AlbumViewModel = AlbumViewModel(isLoginUser: true)
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                if !showAlbum {
                    playlistView
                        .onAppear {
                            plistVm.getLoginUserPlaylist()
                        }
                }
                if showAlbum {
                    albumView
                        .onAppear {
                            albumVm.getCurrentUserAlbums()
                        }
                }
                Spacer()
                
            }.navigationTitle("Library")
        }
    }
    private var playlistView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let playlist = plistVm.currentUserPlaylist?.items {
                    ForEach(playlist, id: \.id) { plist in
                        NavigationLink(destination: PlaylistView(playlist: plist)) {
                            listRowDesign(imgUrlStr: plist.images.first?.url ?? "", title: plist.name, secondTitle: plist.owner.displayName ?? "", subTitle: plist.itemDescription, imgCornerRadius: 4)
                        }
                    }
                    if playlist.count == 0 {
                        Text("There is no any playlist")
                    }
                }
            }
        }
        .transition(.move(edge: .leading))
    }
    
    private func listRowDesign(imgUrlStr: String = "", title: String = "", secondTitle: String = "", subTitle: String = "", imgCornerRadius: CGFloat = 45) -> some View {
        HStack (alignment: .center){
            AsyncImage(url: URL(string: imgUrlStr)){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 45, height: 45, alignment: .center)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(imgCornerRadius)
            VStack (alignment: .leading){
                Text(title)
                    .lineLimit(1)
                    .font(.system(size: 18, weight: .medium))
                Text(secondTitle)
                    .lineLimit(1)
                    .font(.subheadline)
                if subTitle != "" {
                    Text(subTitle)
                        .lineLimit(1)
                        .font(.footnote)
                }
                
            }
        }.foregroundColor(.primary)
    }
    
    private var albumView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(albumVm.currUserAlbums, id: \.id) { album in
                    NavigationLink(destination: AlbumView(album: album)) {
                        listRowDesign(imgUrlStr: album.images.first?.url ?? "", title: album.name, secondTitle: Helper.getArtistsName(artists: album.artists), subTitle: "\(album.totalTracks) Song", imgCornerRadius: 4)
                    }
                }
            }
            if albumVm.currUserAlbums.count == 0 {
                Text("There is no any albums")
            }
            
        }
        .transition(.move(edge: .trailing))
    }
    
    private var headerView: some View {
        VStack {
            HStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        self.showAlbum = false
                    }
                }) {
                    VStack (spacing:0){
                        Text("Playlist")
                            .font(.subheadline)
                            .bold()
                            .padding(.bottom,7.5)
                        if (!showAlbum) {
                            Color.green.frame(width: Helper.screenWidth/4, height: 5, alignment: .center)
                                .cornerRadius(5)
                                .transition(.move(edge: .trailing))
                        }
                        if (showAlbum) {
                            Color.clear.frame(width: Helper.screenWidth/4, height: 5, alignment: .center)
                                .cornerRadius(5)
                                .transition(.move(edge: .leading))
                        }
                    }
                    .frame(height: 25)
                }
                
                Button(action: {
                    withAnimation {
                        self.showAlbum = true
                    }
                }) {
                    VStack (spacing:0){
                        Text("Album")
                            .font(.subheadline)
                            .bold()
                            .padding(.bottom,7.5)
                        if(showAlbum) {
                            Color.green.frame(width: Helper.screenWidth/4, height: 5, alignment: .center)
                                .cornerRadius(5)
                                .transition(.move(edge: .leading))
                        }
                        if(!showAlbum) {
                            Color.clear.frame(width: Helper.screenWidth/4, height: 5, alignment: .center)
                                .cornerRadius(5)
                                .transition(.move(edge: .trailing))
                        }
                    }
                    .frame(height: 40)
                }
                .frame(height: 25)
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(.primary)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
