//
//  WelcomeView.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import SwiftUI

struct WelcomeView: View {
    let screenWidth = UIScreen.main.bounds.size.width
    
    @StateObject var authManager: AuthManager = AuthManager.shared
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("albumCover")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                    titleView
                    Spacer()
                    logoView
                    Spacer()
                    buttonView
                }
            }
        }
    }
    
    private var titleView: some View {
        Text("Spotify")
            .foregroundColor(.white)
            .font(.largeTitle)
            .bold()
            .frame(width: screenWidth - 40, alignment: .leading)
    }
    
    private var logoView: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth/3, alignment: .center)
            Text("Listen to Millions\nof Songs on\nthe go")
                .font(.system(size: 32))
                .fontWeight(Font.Weight.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
        }
    }
    
    private var buttonView: some View {
        NavigationLink(destination: WebUIView(url: authManager.signInURL!)){
            Text("SignIn with Spotify")
                .font(.body)
                .frame(width: screenWidth - 80, alignment: .center)
                .padding()
                .background(Color.white)
                .foregroundColor(Color.black)
                .cornerRadius(25)
        }.navigationBarTitleDisplayMode(.inline)
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
