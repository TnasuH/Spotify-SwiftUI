//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 24.08.2022.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var currentUser: User?

    var apiCaller: APICaller = APICaller.shared
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        
        // New Release
        apiCaller.getCurrentUserProfile {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.currentUser = model
                case .failure(let error):
                    print("Err!1: \(error)")
                }
            }
           
        }
    }
}
