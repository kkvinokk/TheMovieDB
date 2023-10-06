//
//  MovieListViewModel.swift
//  IDMDemoApp
//
//  Created by Abhishek Madhavrao Binniwale (BLR GSS) on 13/03/22.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func movieListResult(movies: [MovieModel])
}

class MovieListViewModel {

    weak var delgate: MovieListViewModelDelegate?

    func getMovieList() {
        /// Can handle the pagination here by keeping the current page count
        Task {
            let result = await NetworkManager.shared.getListOfMovies(pageId: 1, language: "en-US")
            switch result {
            case .success(let movieList):
                self.delgate?.movieListResult(movies: movieList.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
