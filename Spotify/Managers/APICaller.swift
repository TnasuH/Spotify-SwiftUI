//
//  APICaller.swift
//  Spotify
//
//  Created by Tarik Nasuhoglu on 23.08.2022.
//

import Foundation

public struct PublicConstant {
    static var loginUserId: String = ""
    static let ud_loginUserId = "loginUserId"
    
    static func getLoginUserId() -> String{
        if loginUserId.isEmpty {
            loginUserId = UserDefaults.standard.string(forKey: PublicConstant.ud_loginUserId) ?? ""
        }
        return loginUserId
    }
    
    static func setLoginUserId(userId: String){
        UserDefaults.standard.set(userId, forKey: PublicConstant.ud_loginUserId)
    }
}

final class APICaller {
    
    static let shared = APICaller()
    
    private init() {
    }
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    // MARK: - Artist
    
    public func getArtistAlbums(artistId: String,completion: @escaping (Result<Albums, Error>) -> Void) {
        print(artistId)
        let urlStr = Constants.baseAPIURL + "/artists/\(artistId)/albums"
        print("request will prepare for: \(urlStr) ")
        createRequest(with: URL(string: urlStr), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    HELP FOR HOUSTON
//                    let jsonData = try JSONSerialization.jsonObject(with: data)
//                    if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//                        print(JSONString)
//                    }
                    let result = try JSONDecoder().decode(Albums.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            })
            task.resume()
        }
    }
    

    // MARK: - Albums
    
    public func getAlbumDetail(for albumId: String, completion: @escaping (Result<GetAlbums,Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + albumId), type: .GET)
        { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(GetAlbums.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            })
            task.resume()
        }
    }
    
    public func getCurrentUserAlbums(completion: @escaping (Result<[Album],Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/albums"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LibraryAlbumsResponse.self, from: data)
                    completion(.success(result.items.compactMap({ $0.album })))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            })
            task.resume()
        }
        
    }
    
    public func saveAlbum(albumId: String, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/albums?ids=\(albumId)"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let code = (response as? HTTPURLResponse)?.statusCode,
                      error == nil else {
                          completion(false)
                          return
                      }
                completion(code == 200)
            }
            task.resume()
        }
    }
    
    // MARK: - Playlists
    public func getPlaylists(for playlistsId: String, completion: @escaping (Result<GetPlaylists, Error>) -> Void) {
        print(Constants.baseAPIURL + "/playlists/" + playlistsId)
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlistsId), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GetPlaylists.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getCurrentUserPlaylists(limit: Int, offset: Int, completion: @escaping (Result<Playlists, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists?limit=\(limit)&offset=\(offset)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Playlists.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let url = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                self?.createRequest(
                    with: URL(string: url),
                    type: .POST
                ) { baseRequest in
                    var request = baseRequest
                    let jsonParams = [
                        "name": name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: jsonParams, options: .fragmentsAllowed)
                    
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                            if let response = result as? [String:Any], response["id"] as? String != nil {
                                completion(true)
                            }else {
                                completion(false)
                            }
                        }
                        catch {
                            print(error)
                            completion(false)
                        }
                    }
                    task.resume()
                }
                
            case .failure(_):
                completion(false)
            }
        }
    }
    
    public func addTrackToPlaylist(track: Track, playlist: PlaylistsItem, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": [
                    "spotify:track:\(track.id)"
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    if let response = result as? [String:Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }else {
                        completion(false)
                    }
                }
                catch {
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: Track, playlist: PlaylistsItem, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .DELETE) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": [
                    "spotify:track:\(track.id)"
                ]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    if let response = result as? [String:Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }else {
                        completion(false)
                    }
                }
                catch {
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    
    
    
    // MARK: - Browse API
    
    public func getNewReleases(offset: Int, limit: Int,completion: @escaping (Result<NewReleases, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=\(limit)&offset=\(offset)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleases.self, from: data)
                    completion(.success(result))
                } catch {
                    print("Err!: \(error)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getAllFeaturedPlaylists(limit: Int, offset: Int, completion: @escaping (Result<FeaturedPlaylists, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=\(limit)&offset=\(offset)"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, urlResponse, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
//                    HELP FOR HOUSTON
//                    let jsonData = try JSONSerialization.jsonObject(with: data)
//                    if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//                       print(JSONString)
//                    }
                    let result = try JSONDecoder().decode(FeaturedPlaylists.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
                createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { baseRequest in
                    let task = URLSession.shared.dataTask(with: baseRequest) { data, urlResponse, error in
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
                            completion(.success(result))
                        }
                        catch {
                            completion(.failure(error))
                        }
                    }
                    task.resume()
                }
            }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping (Result<Recommendations, Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(Recommendations.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - User Profile API
    
    public func getCurrentUserProfile(completion: @escaping (Result<User, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with:  baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(User.self, from: data)
                    PublicConstant.setLoginUserId(userId: result.id)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Category
    
    public func getCategories(completion: @escaping (Result<[CategoryItem], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GetCategories.self, from: data)
                    completion(.success(result.categories.items))
                    print(result)
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylist(categoryId: String, offset: Int, limit: Int, completion: @escaping (Result<Playlists, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(categoryId)/playlists?limit=\(limit)&offset=\(offset)"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GetCategoryPlaylists.self, from: data)
                    completion(.success(result.playlists))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Search
    
    public func search(with query: String, limit: Int, offset: Int, type: String, completion: @escaping (Result<GetSearch, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=\(limit)&offset=\(offset)&type=album,playlist,track,artist&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GetSearch.self, from: data)
                    
                    completion(.success(result))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    // MARK: - Private
    
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}

