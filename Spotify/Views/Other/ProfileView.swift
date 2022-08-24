//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        let imageUrl = vm.currentUser?.images?.first?.url ?? ""
        return ZStack {
            Group {
                Image("albumCover")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Helper.screenWidth, alignment: .center)
                Color.black
                    .opacity(0.8)
            }.ignoresSafeArea()
            VStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                    
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(height: 200, alignment: .center)
                
                Text(vm.currentUser?.displayName ?? "")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                HStack(alignment: .center){
                    userInfoWithCount(count: 20, desc: "PlayLists")
                    Spacer()
                    userInfoWithCount(count: 30, desc: "Followers")
                    Spacer()
                    userInfoWithCount(count: 120, desc: "Following")
                }
                .padding(.horizontal,20)
                .padding(.top,5)
                List {
                    userInfoRow(label: "Email", val: vm.currentUser?.email ?? "")
                    userInfoRow(label: "Subscription Type", val: vm.currentUser?.product ?? "")
                    //vm.currentUser?.type?.rawValue ?? "")
                    userInfoRow(label: "Country", val: vm.currentUser?.country ?? "")
                    //                    Text(vm.currentUser.)
                }.disabled(true)
                
                Button(action: {
                    AuthManager.shared.signOut { result in print("logout Clicked")
                }}) {
                    Text("Logout")
                        .font(.body)
                        .bold()
                        .frame(width: Helper.screenWidth - 80, alignment: .center)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .cornerRadius(25)
                }
                .padding(.bottom,60)
            }
        }
    }
    
    private func userInfoRow(label: String, val:String) -> some View {
        return HStack(alignment: .center) {
            Text(label)
                .bold()
            Spacer()
            Text(val)
        }
    }
    
    private func userInfoWithCount(count: Int, desc: String) -> some View {
        return VStack{
            Text("\(count)")
                .bold()
            Text(desc)
                .font(.subheadline)
        }
        .foregroundColor(.white)
        
    }
}

struct ProfileViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
