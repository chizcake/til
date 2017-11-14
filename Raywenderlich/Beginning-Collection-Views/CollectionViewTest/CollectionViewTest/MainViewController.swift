//
//  MainViewController.swift
//  CollectionViewTest
//
//  Created by Henry on 04/11/2017.
//  Copyright © 2017 Henry. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let itemSpacing = CGFloat(10)
    private let itemsInRow = 3
    private var dataSource = DataSource()

    private lazy var flowLayout: FlowLayout = {
        let layout = FlowLayout()
        let itemWidth = view.bounds.size.width / CGFloat(itemsInRow)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DataCell.self, forCellWithReuseIdentifier: "\(DataCell.self)")
        collectionView.register(DataHeaderCell.self,
                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                    withReuseIdentifier: "\(DataHeaderCell.self)")
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainViewController()
    }

    deinit {
        NSLog("MainViewController is deallocated")
    }

    private func setupMainViewController() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)])

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl

        navigationItem.title = "National Parks"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                            action: #selector(addPark))
    }

    @objc private func addPark() {
        guard let indexPath = dataSource.indexPathForNewRandomPark(),
              let currentLayout = collectionView.collectionViewLayout as? FlowLayout else { return }

        currentLayout.addedItem = indexPath
        let section = dataSource.sectionAtIndexPath(indexPath)
        section?.appendPark()
        collectionView.insertItems(at: [indexPath])
        collectionView.reloadSections(IndexSet(arrayLiteral: indexPath.section))

        /// FIXME: FOR DEBUGGING
        print(dataSource)
    }

    @objc private func deleteCollectionData() {
        guard let indexPaths = collectionView.indexPathsForSelectedItems,
              let currentLayout = collectionView.collectionViewLayout as? FlowLayout else { return }

        let reverseSortedIndexPaths = indexPaths.sorted(by: sortIndexPathReversely)
        collectionView.performBatchUpdates({
            currentLayout.removedItems = reverseSortedIndexPaths
            dataSource.deleteItemsAtIndexPaths(reverseSortedIndexPaths)
            collectionView.deleteItems(at: reverseSortedIndexPaths)
        })

//        for section in reverseSortedIndexPaths.map({$0.section}) {
//            collectionView.reloadSections(IndexSet(arrayLiteral: section))
//        }

        navigationItem.rightBarButtonItem?.isEnabled = false

        /// FIXME: FOR DEBUGGING
        print(dataSource)
    }

    @objc private func handleRefreshControl() {
        guard let refreshControl = collectionView.refreshControl else { return }
        addPark()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        navigationItem.rightBarButtonItem = editing ?
            UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteCollectionData)) :
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPark))

        if editing { navigationItem.rightBarButtonItem?.isEnabled = false }
        collectionView.reloadData()
    }

    private func sortIndexPathReversely(_ lhs: IndexPath, _ rhs: IndexPath) -> Bool {
        if lhs.section < rhs.section { return false }
        else if lhs.section > rhs.section { return true }
        else {
            if lhs.item < rhs.item { return false }
            else { return true }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfParks(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DataCell.self)", for: indexPath)
        guard let dataCell = cell as? DataCell else { return cell }

        dataCell.park = dataSource.parkForItemAtIndexPath(indexPath)
        dataCell.isEditing = isEditing

        return dataCell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let dataHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: "\(DataHeaderCell.self)",
                                                                                   for: indexPath) as? DataHeaderCell else {
            return UICollectionReusableView()
        }

        guard let section = dataSource.sectionAtIndexPath(indexPath) else { return UICollectionReusableView() }
        dataHeaderCell.section = section
        return dataHeaderCell
    }
}

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing, let indexPaths = collectionView.indexPathsForSelectedItems, indexPaths.isEmpty == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else {
//            let content = collectionData[indexPath.item]
//            navigationController?.pushViewController(DetailViewController(content: content), animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard isEditing, let indexPaths = collectionView.indexPathsForSelectedItems, indexPaths.isEmpty else { return }
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
}
