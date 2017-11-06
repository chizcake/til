//
//  DetailViewController.swift
//  CollectionViewTest
//
//  Created by Henry on 04/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private let content: String
    private let contentLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .black
        return $0
    }(UILabel())

    init(content: String) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NSLog("DetailViewController is deallocated")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailViewController()
    }

    private func setupDetailViewController() {
        view.addSubview(contentLabel)
        view.backgroundColor = .white

        contentLabel.text = content
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)])
    }
}
