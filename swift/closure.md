> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 클로저 (Closure)

* 클로저는 정의된 기능을 수행하는, 코드 블록이다. 정의된 기능을 수행하는 점에서는 함수와 비슷해 보이지만, 일단 지금까지 이해한 바로 클로저는 함수와는 달리 이름이 존재하지 않는다. 그래서 어떤 기능을 반복적으로 수행할 때에는 클로저가 아닌 함수를 선언하는 것이 바람직하다. 그러나 반대로 한번만 사용되고, 여러번 호출되지 않는 기능을 구현해야 할 때는 굳이 함수를 사용하지 않고 클로저를 사용할 수 있다.

```swift
func getDouble(item: Int) -> Int {
    return item * 2
}

var array = [10, 20, 30, 40, 50]
// func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
var doubledArray = array.map(getDouble)     // [20, 40, 60, 80, 100]
```

> 위의 코드와 같이 매개변수로 입력받은 값을 2배로 증가시켜주는 함수를 정의한 다음에 이를 map 함수에 넣어서 배열에 속한 item 의 값을 2배로 증가시킬 수도 있다. 그러나 getDouble 함수가 여기에서만 사용되고, 더 이상 사용될 일이 없다면 위와 같이 함수를 정의해서 사용하는 것은 비효율적으로 보인다. 이럴 땐 클로저를 사용하면 좋다.

```swift
var array = [10, 20, 30, 40, 50]
var doubledArray = array.map {(item: Int) -> Int in 
    return item * 2
}

// func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]
var names = ["Michael", "John", "Oliver", "Luke", "Manny"]
var ascendingNames = names.sorted(by: { 
    (s1: String, s2: String) -> Bool in
    return s1 < s2
})
```

> 첫번째 코드와 두번째 코드는 주어진 배열에 저장된 아이템 값을 2배 증가시켜주는, 같은 작업을 수행하지만 두번째 코드에는 클로저를 사용함으로써 훨씬 효율적인 코드가 되었다.

