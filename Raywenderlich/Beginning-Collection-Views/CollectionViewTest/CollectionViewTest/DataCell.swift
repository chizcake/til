//
//  DataCell.swift
//  CollectionViewTest
//
//  Created by Henry on 04/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class DataCell: UICollectionViewCell {

    let contentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataCell()
    }

    private func setupDataCell() {
        contentView.backgroundColor = UIColor(named: "rayColor")
        contentView.addSubview(contentLabel)
        contentView.addSubview(checkingImageView)

        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkingImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            checkingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            checkingImageView.widthAnchor.constraint(equalToConstant: 30.0),
            checkingImageView.heightAnchor.constraint(equalToConstant: 30.0)])
    }
}
