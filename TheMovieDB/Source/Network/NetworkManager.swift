//
//  NetworkManager.swift
//  IDMDemoApp
//
//  Created by Abhishek Madhavrao Binniwale (BLR GSS) on 13/03/22.
//

//https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1

import Foundation

/// Singleton class
class NetworkManager {

    static let shared = NetworkManager()

    private init() { }

    func getListOfMovies(pageId: Int, language: String) async -> Result<MovieList, Error> {
        let apiUrl = APIURL(environment: .development)
        let apikey = apiUrl.apiKey()
        let movieBaseUrl = apiUrl.baseURL()
        let urlString = "\(movieBaseUrl)/3/movie/now_playing?api_key=\(apikey)&language=\(language)&page=\(pageId)"

        print("urlString:\(urlString)")

        guard let url = URL(string: urlString) else {
            return .failure(NetworkError.invalidURL)
        }

        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let movieList = try JSONDecoder().decode(MovieList.self, from: data)
            return .success(movieList)
        } catch let jsonError {
            print("Error: \(jsonError)")
            return .failure(NetworkError.responseError)
        }
    }
}
