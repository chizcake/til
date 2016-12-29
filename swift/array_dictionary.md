> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 배열 (array)

* 다수의 데이터를 효율적으로 저장하고자 할 때 사용하는 자료구조이다.
* 배열을 선언할 때 저장할 자료형을 명시하거나, 배열을 선언함과 동시에 데이터를 저장함으로써 자료형을 추정할 수도 있다.

```swift
// 배열을 선언하는 3가지 방법
var intArray1 = [1, 2, 3, 4, 5]
var intArray2: Array<Int>
var intArray3: [Int]

// 서로 다른 타입의 데이터를 한 배열에 저장하는 것도 가능하다.
var anyArray: Array<Any>
anyArray = [0, 1, 2, "Hello", "Swift", 3.1415]
```

* 배열을 초기화하는 방법은 다양하다

```swift
var array1 = [Double](repeating: 0.0, count: 3)     // [0, 0, 0]
var array2 = [Int](repeating: 1, count: 4)          // [1, 1, 1, 1]
var array3 = array2 + array2                        // [1, 1, 1, 1, 1, 1, 1, 1] (concatenated)
var array4 = [String]()                             // [] (empty array, count = 0 인 상태)
```

* 초기화된 배열에 새로운 원소를 추가하는 방법

```swift
var stringArray = ["Hello", "Swift"]                // ["Hello", "Swift"]
stringArray.append("Apple")                         // ["Hello", "Swift", "Apple"], append 함수에는 1개의 매개변수만 입력받을 수 있다.

stringArray += ["Banana", "Melon"]                  // ["Hello", "Swift", "Apple", "Banana", "Melon"]
```

> 배열 선언만 되고 초기화가 되지 않은 상태에서는 append 함수나 '+=' 연산을 통해 원소를 배열에 추가할 수 없다. (기존에 배열에 값이 존재할 때만 append 가능)

* 배열이 비어있는지 확인하는 방법

```swift
var array1 = [String]()
if array1.isEmpty {
    print("This array is empty")            // "This array is empty" 가 출력될 것이다.
} else {
    print("This array is not empty")
}

var array2: [String]
/* error: 초기화가 되지 않은 배열은 null 과 같아서 count 나 isEmpty 와 같은 배열 함수를 사용할 수가 없다.
if array2.isEmpty {
    print("This array is empty")
} else {
    print("This array is not empty")
}
*/
```

* 배열에 저장된 값 수정하는 방법

```swift
var array1 = [10, 20, 30, 40, 50]
array1[4] = 90                          // [10, 20, 30, 40, 90]
array1[1...3] = [200, 300, 400]         // [10, 200, 300, 400, 90]
array1[1...4] = [50, 70]                // [10, 50, 70]     <- 그 뒤에 있던 숫자는 다 지워진다는 것을 명심하자. 
```

> map 함수를 통해서 배열에 **일관된 작업**을 수행할 때 좀 더 효율적인 코딩을 할 수 있다.

```swift
func getDouble(item: Int) -> Int {
    return item * 2
}

// func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
var array = [10, 20, 30, 40, 50]
var doubledArray = array.map(getDouble)     // 원래의 array 배열에 속한 item 은 값이 변하지 않는다.
```

* 배열에 저장된 값을 순회하는 방법

```swift
var stringArray = ["Hello", "Swift", "Apple", "Banana"]
for item in stringArray {
    print(item)
}

// enumerated 함수를 사용해서 배열의 인덱스와 저장된 값을 tuple 형으로 받아올 수도 있다.
for (index, value) in stringArray.enumerated() {
    print("item \(index): \(value)")
}
```

## 딕셔너리 (Dictionary)

* 키와 값을 쌍으로 가지는 자료구조이다.
* 선언 방법이나 초기화 방법은 배열과 비슷하다.

```swift
var dic1 = [
    "Name"  : "JUNYEONG",
    "Age"   : "28",
    "Phone" : "010-1234-1234"
]
var dic2 = Dictionary<String, String>()

// Dictionary 에 저장된 값을 변경하는 방법
dic1["Age"] = "25"
dic1.updateValue = ("010-1111-1111", forKey: "Phone")
```

* 딕셔너리에 저장된 값을 순회하는 방법은 다음과 같다.

```swift
// tuple 을 이용해서 저장된 값을 가져오는 방법
for (key, value) in dic1 {
    print("\(key) : \(value)")
}

// Dictionary 의 key 를 가져오는 방법
for key in dic1.keys {
    print(key)
}

// Dictionary 의 value 를 가져오는 방법
for value in dic1.values {
    print(value)
}
```

* 딕셔너리에 저장된 key 또는 value 를 배열로 casting 하는 것도 가능하다.

```swift
var keyArrays = Array(dic1.keys)
var valueArrays = Array(dic1.values)
```
