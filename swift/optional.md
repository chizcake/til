> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## nil

* Swift 는 안정성을 중요하게 생각하는 언어이므로 기본적으로 Swift 의 일반 변수나 참조 변수는 nil 값을 가질 수 없다.
    - 객체가 nil 이 되면, 이 객체에 메시지를 줄 경우 crash 가 발생하며 이는 프로그램의 안정성이 떨어지는 원인이 된다. (Java 의 NullPointerException 이라고 생각하면 될 것 같다.)
    
## Optional 변수

* Optional 은 상수와 변수의 **값의 유, 무를 검사**할 때 사용한다.
    - 일반 변수가 가질 수 있는 값: 실제 값
    - Optional 변수가 가질 수 있는 값: 실제 값 또는 nil 값
    
* Optional 자료형은 선언한 자료형의 값 또는 nil 값이 나올 수도 있을 경우에 사용한다.
    - `var num = Int("100")` 이라고 선언했을 경우 Swift 는 num 의 자료형을 Int? 라고 추정한다. 이 때 **Int?** 는 Optional 자료형으로서 Int 값 또는 nil 값을 저장할 수 있다.

```swift
var num = Int("100")        // optional(100)
//var num: Int = Int("100") // error: Int? 값을 Int 에 저장하려고 한다.
var num2: Int? = Int("100") // optional(100)
num2 = Int("Hello")         // nil
```

## Wrapped Optional

* 위에서 살펴본 것처럼 `Int("100")` 을 통해 반환된 데이터는 optional(100) 이다. optional 은 nil 이 될 가능성이 있는 값이라는 의미를 가진다. 이 때 optional(...) 을 **wrapped optional** 이라고 한다.
    - wrapped optional 변수 간의 연산은 불가능하다.
    - 연산 작업을 하기 위해선 wrapped optional 을 **unwrapped** 해야 한다. 이 때 '!' 연산자를 사용한다.
    - `optional(100)! == 100`
    
* Optional 변수는 사용하기 전에 반드시 nil 검사를 해서 안정성을 확보해야 한다.

```swift
struct Person {
    var name: String?
    var age: Int
}

var person: Person? = Person(name: "홍길동", age: 27)
person = nil

/* person 이 nil 로 할당되었기 때문에 아래의 코드는 오류를 일으킨다. */
//print("name: \(person!.name!), age: \(person!.age)")

/* 다음과 같이 Optional 변수가 nil 인지 확인을 한 후에 사용해야 한다. */
if person != nil {
    if person!.name != nil {
        print("name: \(person!.name!), age: \(person!.age)")
    }
}
```

## Optional Chain

* 위의 코드에서 Optional 변수가 nil 인지 확인을 하기 위해서 if 문을 여러번 중첩하고 있다. 만약 nil 확인을 여러번 해야하는 상황이 되면 코드의 가독성이 떨어지고 코딩 과정에서 오류가 발생할 소지가 있다. 그래서 중첩 if 문의 대안으로 사용할 수 있는 것이 **Optional Chain** 이다.

```swift
// if 문을 여러 번 중첩해서 확인해야 할 name 값을 if 문 하나로 해결한다. 
if let personName = person?.name {
    print("name: \(personName)")
}

person?.name = "임꺽정"
if let personName = person?.name {
    print("name: \(personName)")
}
```