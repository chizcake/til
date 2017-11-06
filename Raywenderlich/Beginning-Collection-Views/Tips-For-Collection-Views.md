## How to Refresh Collection Views through pulling down the scroll

```swift
let refreshControl = UIRefreshControl()
refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
collectionView.refreshControl = refreshControl  // Collection view already has a property `refreshControl`

@objc private func handleRefreshControl() {
  foo()  // Add a method to do something while refreshing control is working
  collectionView.refreshControl?.endRefreshing()
}
```