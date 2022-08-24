//
//  TempView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI
import WebKit

struct TempView: View {
    
    @StateObject var authManager: AuthManager = AuthManager.shared
    var text: String
    var body: some View {
        if authManager.isSignedIn {
            VStack {
                Text(text)
                Button("Logout") {
                    authManager.signOut { Bool in
                        print("signout success \(Bool)")
                    }
                }
            }
        }
        if !authManager.isSignedIn {
            //Show Login Page
            WebUIView(url: authManager.signInURL!)
        }
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
