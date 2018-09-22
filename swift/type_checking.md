> The examples that I use here are referenced in [this blog](http://alisoftware.github.io/swift/pattern-matching/2016/03/27/pattern-matching-1/).

## Type Checking in Swift
_Enumeration_ offered in Swift is very powerful with **Type Checking**. Also we can use `switch` to check the types clearly.

* Type matching with tuple

```Swift
enum Media {
  case book(title: String, author: String, year: Int)
  case movie(title: String, director: String, year: Int)
  case website(title: String, url: URL)
}

extension Media {
  var createdDate: Int {
    switch self {
    // You can use `case let .book(_, _, year):` or `case let .book(title: _, author: _, year: aYear)`.
    // In the case below, `info` is being used as tuple. It seems more easy to read.
    case let book(info):
      return info.year
    case let movie(info):
      return info.year
    case website:
      return -1
    }
  }
}
```

* Type checking with `as` and `is`

```swift
protocol Medium {
  var title: String
}

struct Book: Medium {
  let title: String
  let author: String
  let year: Int
}

struct Movie: Medium {
  let title: String
  let director: String
  let year: Int
}

struct Website: Medium {
  let title: String
  let url: URL
}

let media: [Medium] = [
  Book(title: "20,000 leagues under the sea", author: "Jules Verne", year: 1870),
  Movie(title: "20,000 leagues under the sea", director: "Richard Fleischer", year: 1955),
  Website(title: "Alisoftware.io", url: URL(string: "alisoftware.io")!)
]

media.forEach {
  switch $0 {
  case let medium as Book:
      print("Book published in \(medium.year)")
  case let medium as Movie:
      print("Movie published in \(medium.year)")
  // See also: https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html
  // In this case, we don't have to use `as` since we are not going to use type casted value.
  // Just check it out whether the value is of a certain subclass type.
  case is Website:
      print("A website with no date")
  default:
      print("No year info for \($0)")
  }
}
```
