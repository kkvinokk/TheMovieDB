//
//  MovieListCell.swift
//  TheMovieDB
//
//  Created by Vinothanandan  Sachidanandam on 30/09/23.
//

import UIKit

class MovieListCell: UITableViewCell {
    static let reuseIdentifier = "AnimalCell"

    // MARK: - Views
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 26)
        label.textColor = .red
        label.numberOfLines = 1
        return label
    }()

    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 3
        return label
    }()

    private var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()

    let rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func bind(to movie: MovieModel) {
        titleLabel.text = movie.title
        subTitleLabel.text = movie.overview
        icon.downloadImageFrom(path: movie.poster_path, contentMode: .scaleAspectFill)
    }

    // MARK: - SetupUI
    func setupUI() {
        selectionStyle = .none
        setupSubViews()
        setupConstraint()
    }

    private func setupSubViews() {
        rightStackView.addArrangedSubview(titleLabel)
        rightStackView.addArrangedSubview(subTitleLabel)
        mainStackView.addArrangedSubview(icon)
        mainStackView.addArrangedSubview(rightStackView)

        contentView.addSubview(mainStackView)
    }

    private func setupConstraint() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            icon.widthAnchor.constraint(equalToConstant: 60),
            rightStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
