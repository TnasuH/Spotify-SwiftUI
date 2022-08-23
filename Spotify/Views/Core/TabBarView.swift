//
//  TabBarView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            TempView(text:"Home Screen")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            TempView(text:"Search Screen")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            TempView(text:"Library Screen")
                .tabItem {
                    Label("Library", systemImage: "music.note.list")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
