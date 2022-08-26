//
//  CategoryPlaylistView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 26.08.2022.
//

import SwiftUI

struct CategoryPlaylistView: View {
    var category: CategoryItem
    @ObservedObject var vm: PlaylistViewModel
    
    @State private var showDetail = false
    
    static let rowSize = Double((Helper.screenWidth)/2)
    
    let columns = [
        GridItem(.fixed(rowSize)),
        GridItem(.fixed(rowSize))
    ]
    
    var body: some View {
        
        return ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                ZStack{
                    playlistIcon
                        .rotationEffect(.degrees(showDetail ? -23 : 0))
                        .padding(.leading, showDetail ? 120 : 0)
                    playlistIcon
                        .rotationEffect(.degrees(showDetail ? -10 : 0))
                        .padding(.leading, showDetail ? 60 : 0)
                    playlistIcon
                }
                if let plist = vm.categoryPlaylists {
                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(plist.items, id:\.id) { plistitem in
                            NavigationLink(destination: {
                                PlaylistView(playlist: plistitem)
                            }, label: {
                                featuredPlaylistCell(plistItem: plistitem)
                            })
                        }
                        ListPlaceholderRowView(state: vm.playlistState, loadMore: {
                            vm.getCategoryPlaylistMore()
                        })
                    }.foregroundColor(.primary)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                withAnimation {
                    self.showDetail = true
                }
            }
            vm.getCategoryPlaylist()
        }
        .onDisappear(perform: {
            self.showDetail = false
        })
        .navigationTitle(category.name)
    }
    
    private var playlistIcon: some View {
        AsyncImage(url: URL(string: category.icons.first?.url ?? "")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .aspectRatio(contentMode: .fit)
        .frame(height: 120, alignment: .center)
        .cornerRadius(5)
        .padding(.bottom,10)
    }
    
    private func featuredPlaylistCell(plistItem: PlaylistsItem) -> some View {
        let playlistImageUrlString = plistItem.images.first?.url ?? ""
        return ZStack{
            VStack(alignment: .center, spacing: 0) {
                AsyncImage(url: URL(string: playlistImageUrlString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .frame(width: Helper.screenWidth/3)
                
                VStack(alignment: .center, spacing: 0){
                    Text("\(plistItem.name)")
                        .font(.title3)
                        .bold()
                    Text(plistItem.owner.name ?? "")
                        .font(.subheadline)
                }
                .padding(.top,5)
            }
            .frame(height: Helper.screenWidth/2.2, alignment: .leading)
        }
    }
}

struct CategoryPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPlaylistView(category: CategoryItem(id: "", name: "", icons: []),
                             vm: PlaylistViewModel(categoryPlaylistId: ""))
    }
}
