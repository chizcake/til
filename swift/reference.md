> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 메모리의 Heap 영역

* 동적으로 메모리를 할당할 때 객체가 위치하는 영역

## 자동 참조 계수 (ARC)

* Java 에서는 Garbage Collector (이하 GC) 를 사용하여 동적으로 할당된 메모리를 관리한다. 개발자가 메모리 관리에 크게 신경을 쓰지 않아도 된다는 장점은 있지만, GC 가 수시로 실행되어 시스템에 부하를 준다는 단점이 있다.

* C/C++ 에서는 개발자가 할당한 동적 메모리를 직접 해제해야 한다. 따라서 에러가 발생할 소지가 있다.

* **자동 참조 관리기법**은 자동 참조 계수를 통해 프로그램의 동적 메모리 사용을 추적하고 관리하는 방법이다. 자동 참조 계수를 통해 필요없는 클래스 인스턴스의 메모리를 자동으로 해제할 수도 있으며, 이 기법은 클래스의 인스턴스에만 적용된다. 

```swift
class Person {
    
    var name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("Person instance is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?


reference1 = Person(name: "JUNYEONG")

reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil    // Person 인스턴스가 마지막으로 해제되는 순간에 deinit 함수가 호출된다.
```

## 강한 참조

* 객체에 대한 일반적인 참조 방법으로써 참조 계수(count) 가 **증가**한다.
* 강한 참조는 각각의 인스턴스를 해제했음에도 불구하고 메모리에 남아있는 경우가 발생할 수 있다.

```swift
class Person {
    
    let name: String
    var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    
    let number: Int
    var tenant: Person?
    
    init(number: Int) {
        self.number = number
    }
    
    deinit {
        print("Apartment #\(number) is being deinitialized")
    }
}

var john: Person?
var number73: Apartment?

john = Person(name: "John Legend")
number73 = Apartment(number: 73)

john?.apartment = number73
number73?.tenant = john

//john?.apartment = nil
//number73?.tenant = nil

/* 각각의 인스턴스를 해제해도 인스턴스 내부를 보면 서로를 참조하고 있기 때문에 메모리에 인스턴스가 남아있게 된다. */
john = nil
number73 = nil
```

* 위의 코드를 보면 `john?.apartment = nil` 과 `number73?.tenant = nil` 을 통해서 인스턴스 내부에서 서로 참조하고 있는 것을 해제하고 난 후에, 인스턴스를 해제해야 정상적으로 메모리에서 사라지게 된다.
    - 하지만 이러한 방법은 실수를 유발할 가능성이 크다.
    
## 약한 참조

* 약한 참조는 weak 키워드로 표현하며, 다른 인스턴스를 참조하되 참조 계수(count) 는 **증가하지 않는** 참조이다. 
    - 약한 참조를 하게 되면, **강한 참조가 없을 경우에** 인스턴스는 자동으로 해제가 된다.
    - 약한 참조는 참조할 인스턴스가 존재하지 않을 가능성이 있으믈 항상 Optional 타입으로 선언해야 한다.
    
```swift
class Person {
    
    let name: String
    var apartment: Apartment?
    
    init(name: String) { self.name = name }
    
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    
    let number: Int
    weak var tenant: Person?
    
    init(number: Int) { self.number = number }
    
    deinit { print("Apartment #\(number) is being deinitialized") }
}

var john: Person?
var number73: Apartment?

john = Person(name: "John Legend")
number73 = Apartment(number: 73)

john?.apartment = number73
number73?.tenant = john

number73 = nil
john = nil

/* 여기서는 Person 인스턴스가 Apartment 인스턴스를 강한 참조하고 있기 때문에 `number73 = nil` 이 되어도 Apartment 인스턴스가 해제되지 않는다. `john = nil` 이 실행되어 Person 인스턴스가 해제되어야 비로소 Apartment 인스턴스도 해제된다. */
```