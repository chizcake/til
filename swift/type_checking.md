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

* `if case let ...` We can filter the input that matches only the specific type with this.
```swift
enum Media {
  case book(title: String, author: String, year: Int)
  case movie(title: String, director: String, year: Int)
  case website(urlString: String)
}

let media = Media.movie(title: "Captain America: Civil War", director: "Russo Brothers", year: 2016)

if case let .movie(info) = media {
  print("This is a movie named \(info.title)")
}
```

* We can also use `for case let ...` just like `if case let ...`
```swift
let mediaList: [Media] = [
  .book(title: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", year: 1997),
  .movie(title: "Harry Potter and the Philosopher's Stone", director: "Chris Columbus", year: 2001),
  .book(title: "Harry Potter and the Chamber of Secrets", author: "J.K. Rowling", year: 1999),
  .movie(title: "Harry Potter and the Chamber of Secrets", director: "Chris Columbus", year: 2002),
  .book(title: "Harry Potter and the Prisoner of Azkaban", author: "J.K. Rowling", year: 1999),
  .movie(title: "Harry Potter and the Prisoner of Azkaban", director: "Alfonso Cuarón", year: 2004),
  .movie(title: "J.K. Rowling: A Year in the Life", director: "James Runcie", year: 2007),
  .website(urlString: "https://en.wikipedia.org/wiki/List_of_Harry_Potter-related_topics")
]

print("Movies only: ")
for case let .movie(info) in mediaList {
  print("  - \(info.title) (\(info.year))")
}

/*
Movies only:
  - Harry Potter and the Philosopher's Stone (2001)
  - Harry Potter and the Chamber of Secrets (2002)
  - Harry Potter and the Prisoner of Azkaban (2004)
  - J.K. Rowling: A Year in the Life (2007)
*/
```

* There's a syntactic sugar which is relative with `Optional`
```swift
let values: [Int?] = [0, 1, nil, 3, 4, nil, 6, 7, nil, 9]
for case let value? in values {
  print(value)  // output: 0, 1, 3, 4, 6, 7, 9
}
```

> value? is the same with .some(value) and we can use `value` `Int` type (which is not Optional!) in the internal scope.

* With this syntactic sugar and what I've learned so far, let's mix up and apply it to some complex situation.
```swift
extension Media {
  var title: String? {
    switch self {
    case let .book(info):
      return info.title
    case let .movie(info):
      return info.title
    case .website:
      return nil
    }
  }

  var kind: String {
    switch self {
    case .book:
      return "Book"
    case .movie:
      return "Movie"
    case .website
      return "Website"
    }
  }
}

print("All media with a title starting with 'Harry Potter': ")
for case let (title?, kind) in mediaList.map({ ($0.title, $0.kind) }) where title.hasPrefix("Harry Potter") {
  print("  - [\(kind)] \(title)")
}

/*
All media with a title starting with 'Harry Potter':
  - [Book] Harry Potter and the Philosopher's Stone
  - [Movie] Harry Potter and the Philosopher's Stone
  - [Book] Harry Potter and the Chamber of Secrets
  - [Movie] Harry Potter and the Chamber of Secrets
  - [Book] Harry Potter and the Prisoner of Azkaban
  - [Movie] Harry Potter and the Prisoner of Azkaban
*/
```

* Above code is the same as the follow:
```swift
print("All media with a title starting with 'Harry Potter': ")
for media in mediaList {
  guard let title = media.title else {
    continue
  }

  guard title.hasPrefix("Harry Potter") else {
    continue
  }

  print("  - [\(media.kind)] \(title)")
}
```

> This might be more readable and easy to test than above one, so we have to think about this trade off.
