> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 함수 (Function)

* Swift 에서는 Java 나 C/C++ 에서 사용하던 함수 정의와는 조금 다른 방법을 사용한다.

```swift
// -> (String) 은 myFunc 함수의 반환형이 String 이라는 의미이다.
func myFunc(name: String, value: String) -> (String) {
    return "\(name) : \(value)"
}

func myFunc2(name: String) -> (String) {
    return "Hello, \(name)!"
}
```

* 함수를 사용할 때에는 매개변수에 반드시 레이블을 붙여줘야 한다.

```swift
myFunc(name: "JUNYEONG", value: "Computer Science")
myFunc(name: "TAJO", value: "Economics")

myFunc2(name: "JUNEYONG")
```

* 함수를 정의할 때 레이블에 **별칭 (alias)** 을 지어줄 수 있다.

> 사실 이게 정확한 개념은 아닌 것 같지만, 이해한 바로는 alias 개념인 것 같아서 여기에 적어둔다.

```swift
func myFunc3(name personName: String, major: String) -> String {
    // alias 로 "name" 을 적었지만, 함수를 정의할 때에는 alias 가 아닌 원래의 상수 이름으로 사용한다.
    return "\(personName) : \(major)"
}

// alias 로 지정한 "name" 을 레이블처럼 사용할 수 있다.
myFunc3(name: "JUNYEONG", major: "Computer Science")

func myFunc4(_ name: String, major: String) -> String {
    return "\(name) : \(major)"                         
}

// alias 로 익명 (_) 을 주었기 때문에, 함수를 호출할 때 name 에는 레이블을 적지 않는다. 
myFunc4("TAJO", major: "Economics")
```

* Swift 의 함수에서 리턴형은 tuple 이기 때문에 여러 개의 값을 tuple 로 묶어서 반환하는 것이 가능하다.

```swift
func getPersonInfo() -> (Int, String, Int) {
    return (28, "JUNYEONG", 300)
}

/*
func getPersonInfo() -> (age: Int, name: String, score: Int) {
    return (28, "JUNEYONG", 300)
}

이라고 리턴값에 레이블을 사용할 수도 있다.
*/

var person = getPersonInfo()
print(person.0)     // person.age
print(person.1)     // person.name
print(person.2)     // person.score

// =============================================== //

// Swap 함수 만들기
func swap(p1: Int, p2: Int) -> (Int, Int) {
    return (p2, p1)
}

var n1 = 100, n2 = 200

print("[변경 전] n1: \(n1), n2: \(n2)")        // [변경 전] n1: 100, n2: 200
(n1, n2) = swap(p1: n1, p2: n2)
print("[변경 후] n1: \(n1), n2: \(n2)")        // [변경 후] n1: 200, n2: 100
```

* Swift 에서도 **매개변수에 따른** 오버로딩 함수를 구현하는 것이 가능하다.

```swift
func greeting() {
    print("Hello, Swift!")
}

func greeting(name: String) {
    print("Hello, \(name)")
}

greeting()                      // "Hello, Swift!"
greeting(name: "JUNYEONG")      // "Hello, JUNYEONG!"
```

* 가변인자 함수
    - 함수에 전달되는 매개변수의 수를 정확하게 알 수 없을 때 사용하는 문법이다.
    
```swift
// 매개변수에 주어지는 Double 형 숫자의 평균을 구하는 메소드 
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    
    return total / Double(numbers.count)
}

arithmeticMean(numbers: 3.14, 30.7, 58.1, 14.2)
arithmeticMean(numbers: 3.12, 3, 4.8)
```

* 함수 참조변수

```swift
func addTwoInts(num1: Int, num2: Int) -> Int {
    return num1 + num2
}

var funcVariable: (Int, Int) -> Int

addTwoInts(num1: 5, num2: 3)    // 레이블을 반드시 기입하여야 한다.
funcVariable = addTwoInts
funcVariable(7, 3)              // 함수 참조변수는 레이블을 사용하지 않는다.

```
> 함수 참조변수는 매개변수에도 사용할 수 있다.

```swift
func resultAddTwoInts(addTwoNumbers: (Int, Int) -> Int, num1: Int, num2: Int) {
    print("Result: \(addTwoNumbers(num1, num2))")
}

resultAddTwoInts(addTwoNumbers: addTwoInts, num1: 10, num2: 20)     // 함수를 사용할 때에는 레이블 사용하는 것을 잊지 말자.
```

* 위의 내용을 종합해서 중첩 함수를 만드는 것도 가능하다.

```swift
func chooseStepFunction(backward: Bool) -> ((Int) -> Int) {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    return backward ? stepBackward : stepForward    // 띄어쓰기 주의할 것
}

chooseStepFunction(backward: true)(10)
chooseStepFunction(backward: false)(10)

// 중첩함수의 좀 더 쉬운 예제를 살펴보자.
func outerFunction() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    
    return addOne                   // nested function (함수 내부에 정의된 함수) 를 리턴하는 것도 가능하다.
}

var increment = outerFunction()
print(increment(10))                // 11

// 다음 코드를 통해 중첩함수의 특징을 알 수 있다.
func makeIncrement(amount: Int) -> (() -> Int) {
    var runningTotal = 10
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementor
}

// 함수 참조변수인 incrementFive 와 incrementTen 이 nested function 인 incrementor 를 참조하고 있기 때문에 소멸되지 않고 메모리에 유지된다. 
var incrementFive = makeIncrement(amount: 5)
incrementFive()     // 15
incrementFive()     // 20
incrementFive()     // 25

var incrementTen = makeIncrement(amount: 10)
incrementTen()      // 20
incrementTen()      // 30
incrementTen()      // 40
```

* Swift 함수에서는 **매개변수로 들어온 값을 상수로 인식**하기 때문에 매개변수의 값을 함수 내부에서 변경할 수가 없다.
    - 함수 내부에서 매개변수의 값을 바꾸려면 inout 키워드를 사용해야 한다.
    - inout 키워드를 사용한 함수를 호출할 때는 & 연산자를 사용해야 한다.
    
```swift
func swapTwoIntegers(num1: inout Int, num2: inout Int) {
    let temp = num1
    // inout 키워드를 사용함으로써 함수 내부에서 매개변수의 값을 변경하는 것이 가능해졌다. 
    num1 = num2
    num2 = temp
}

swapTwoIntegers(num1: &value1, num2: &value2)

// 앞서 선보인 적이 있는데, 위의 swap 함수는 inout 키워드를 쓰지 않고, 리턴형이 tuple 인 함수를 정의해서 구현할 수도 있다.
func swapTwoIntegers2(num1: Int, num2: Int) -> (Int, Int) {
    return (num2, num1)
}

(value1, value2) = swapTwoIntegers2(num1: value1, num2: value2)
```
