//
//  ContentView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @StateObject var authManager: AuthManager = AuthManager.shared
    @StateObject var playerVM: PlayerManagerViewModel = PlayerManagerViewModel()
    
    var body: some View {
        if authManager.isSignedIn {
            ZStack(alignment: .bottom){
                TabBarView()
                PlayerView()
            }.environmentObject(playerVM)
        }
        if !authManager.isSignedIn {
            //Show Login Page
            WelcomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
