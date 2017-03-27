# Lecture 02 - Overview Swift Syntax

> [Developing Apps for iOS CS193P by Stanford University](https://www.youtube.com/watch?v=_lRx1zoriPo&list=PLsJq-VuSo2k26duIWzNjXztkZ7VrbppkT)

### Optional

* Optional은 enum으로 정의되어 있다.

```swift
enum Optional<T> {
    case None
    case Some(T)
}

let x: String? = nil        // let x = Optional<String>.None
let y: String? = "Hello"    // let y = Optional<String>.Some("Hello")

/* var z = y! 는 다음과 같이 동작한다. */
switch y {
    case .Some(let value): z = value     // (연관값(value)를 z에 저장)
    case .None:                          // 예외 처리 (nil값을 unwrapping하는 경우)
}

/* if let z = y 는 다음과 같이 동작한다. */
switch y {
    case .Some(let value):
        z = value
        // do something with z
    
    case .None:
        break
}
```

* Optional Chaining을 사용하면 좀 더 코드 길이를 줄일 수 있다.

```swift
var display: UILabel?
if let label = display {
    if let text = label.text {
        let x = text.hashValue
        ...
    }
}

/* 위 코드를 optional chaining을 사용한 경우 */
var display: UILabel?
if let x = display?.text?.hashValue {
    // do something with x
}
```

* Optional이 nil인 경우 변수가 기본값을 갖도록 하는 것도 가능하다.

```swift
let s: String? = ...
if s != nil {
    display.text = s
} else {
    display.text = ""
}

/* 위 코드를 다음과 같이 변경할 수 있다. */
display.text = s ?? ""
```