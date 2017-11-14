//
//  DataCell.swift
//  CollectionViewTest
//
//  Created by Henry on 04/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class DataCell: UICollectionViewCell {

    private let parkImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let gradientView: GradientView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(GradientView())

    private let stackView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .bottom
        $0.distribution = .fill
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    private let parkNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textAlignment = .center
        $0.numberOfLines = 3
        return $0
    }(UILabel())

    private let checkingImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.image = UIImage(named: "Unchecked")
        return $0
    }(UIImageView())

    var isEditing = false {
        didSet {
            checkingImageView.isHidden = !isEditing
        }
    }

    override var isSelected: Bool {
        didSet {
            if isEditing {
                checkingImageView.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }

    var park: Park? {
        didSet {
            guard let park = park else { return }
            parkImageView.image = UIImage(named: park.photo)
            parkNameLabel.text = park.name
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataCell()
    }

    private func setupDataCell() {
        contentView.backgroundColor = .clear
        [parkImageView, gradientView, stackView].forEach {
            contentView.addSubview($0)
        }

        [parkNameLabel, checkingImageView].forEach {
            stackView.addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            parkImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parkImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            parkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            parkImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            gradientView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -8),
            gradientView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            gradientView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gradientView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            checkingImageView.widthAnchor.constraint(equalToConstant: 20),
            checkingImageView.heightAnchor.constraint(equalToConstant: 20)])
    }

    override func prepareForReuse() {
        parkImageView.image = nil
        checkingImageView.image = UIImage(named: "Unchecked")
    }
}
