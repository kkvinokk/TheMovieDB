//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Vinothanandan  Sachidanandam on 01/10/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private var movie: MovieModel

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 26)
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()

    private var subTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 18)
        textView.textColor = .black
        return textView
    }()

    private var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(movie: MovieModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpUI()
    }

    func setUpUI() {
        setupSubViews()
        setupConstraint()
        setupData()
    }

    private func setupData() {
        titleLabel.text = movie.title
        subTextView.text = movie.overview

        // can movie this code to a another class and can handle image cache so will noe need to doenload it everytime
        icon.layer.cornerRadius = 20
        icon.clipsToBounds = true
        icon.downloadImageFrom(path: movie.poster_path, contentMode: .scaleAspectFill)
    }

    private func setupSubViews() {
        view.backgroundColor = .white
        view.addSubview(icon)
        view.addSubview(titleLabel)
        view.addSubview(subTextView)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            icon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            icon.widthAnchor.constraint(equalToConstant: 200),
            icon.heightAnchor.constraint(equalToConstant: 400),

            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: icon.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor),

            subTextView.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16),
            subTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            subTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
