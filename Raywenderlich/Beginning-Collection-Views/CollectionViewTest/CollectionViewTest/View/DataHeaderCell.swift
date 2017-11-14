//
//  DataHeaderCell.swift
//  CollectionViewTest
//
//  Created by Henry on 08/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class DataHeaderCell: UICollectionViewCell {

    private let headerFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private let parkCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()

    var section: Section? {
        didSet {
            guard let section = section else { return }
            headerFlagImageView.image = UIImage(named: section.title)
            headerLabel.text = section.title
            parkCountLabel.text = String(section.parks.count)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataHeaderView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataHeaderView()
    }

    private func setupDataHeaderView() {
        contentView.backgroundColor = .white
        [headerFlagImageView, headerLabel, parkCountLabel].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            headerFlagImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerFlagImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            headerFlagImageView.widthAnchor.constraint(equalToConstant: contentView.frame.size.height),
            headerFlagImageView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height),
            headerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            headerLabel.leftAnchor.constraint(equalTo: headerFlagImageView.rightAnchor, constant: 8),
            headerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            parkCountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            parkCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)])
    }

    override func prepareForReuse() {
        headerFlagImageView.image = nil
        headerLabel.text = nil
        parkCountLabel.text = nil
    }
}
