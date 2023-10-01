//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Vinothanandan  Sachidanandam on 23/09/23.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - Properties
    private var viewModel = MovieListViewModel()
    private var movies = [MovieModel]()

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViews()
        setupTableView()
        setupConstraint()
        setupConstraint()
        setupData()
    }

    private func setupData() {
        viewModel.delgate = self
        getData()
    }

    private func getData() {
        viewModel.getMovieList()
    }

    private func setupSubViews() {
        view.addSubview(tableView)
    }

    private func setupTableView() {
        tableView.register(MovieListCell.self, forCellReuseIdentifier: String(describing: MovieListCell.self))
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView Delegates
extension MovieListViewController: MovieListViewModelDelegate {
    func movieListResult(movies: [MovieModel]) {
        self.movies.append(contentsOf: movies)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListCell.self)) as! MovieListCell
        cell.bind(to: movies[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
}

// MARK: - TableView Delegates
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath)")
        let movie = movies[indexPath.row]
        let movieDetailsVC = MovieDetailsViewController(movie: movie)
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
