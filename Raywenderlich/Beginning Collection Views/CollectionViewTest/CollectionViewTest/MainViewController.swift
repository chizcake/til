//
//  MainViewController.swift
//  CollectionViewTest
//
//  Created by Henry on 04/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var collectionData: [String] = ["1 🐶", "2 🐱", "3 🐭"]
    private let itemSpacing = CGFloat(10)
    private let itemsInRow = 3

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let itemWidth = (view.bounds.size.width - (CGFloat(itemsInRow - 1) * itemSpacing)) / CGFloat(itemsInRow)
        $0.itemSize = CGSize(width: itemWidth, height: itemWidth)
        $0.minimumInteritemSpacing = itemSpacing
        $0.minimumLineSpacing = itemSpacing
        return $0
    }(UICollectionViewFlowLayout())

    private lazy var collectionView: UICollectionView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(DataCell.self, forCellWithReuseIdentifier: "\(DataCell.self)")
        $0.backgroundColor = .clear
        $0.allowsMultipleSelection = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout))

    private let refreshControl: UIRefreshControl = {
        $0.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return $0
    }(UIRefreshControl())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainViewController()
    }

    deinit {
        NSLog("MainViewController is deallocated")
    }

    private func setupMainViewController() {
        view.backgroundColor = .black
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)])

        collectionView.refreshControl = refreshControl

        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                            action: #selector(addCollectionData))

    }

    @objc private func addCollectionData() {
        collectionView.performBatchUpdates({
            for _ in 1 ... 3 {
                let newData = "\(collectionData.count + 1) 🦄"
                collectionData.append(newData)
                let endOfIndexPath = IndexPath(item: collectionData.count - 1, section: 0)
                collectionView.insertItems(at: [endOfIndexPath])
            }
        })
    }

    @objc private func deleteCollectionData() {
        guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
        let reversedIndexes = indexPaths.map{$0.item}.sorted().reversed()
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: indexPaths)
            for index in reversedIndexes {
                collectionData.remove(at: index)
            }
        })
    }

    @objc private func handleRefreshControl() {
        addCollectionData()
        collectionView.refreshControl?.endRefreshing()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItem = editing ?
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteCollectionData)) :
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCollectionData))

        if editing { navigationItem.rightBarButtonItem?.isEnabled = false }
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DataCell.self)", for: indexPath)
        guard let dataCell = cell as? DataCell else { return cell }

        dataCell.contentLabel.text = collectionData[indexPath.item]
        dataCell.isEditing = isEditing

        return dataCell
    }
}

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
            let content = collectionData[indexPath.item]
            navigationController?.pushViewController(DetailViewController(content: content), animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard isEditing, let indexPaths = collectionView.indexPathsForSelectedItems, indexPaths.isEmpty else { return }
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}
