> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)

## 프로토콜 (Protocol)

* Java 의 인터페이스 처럼 특정 객체가 갖추어야 할 기능이나 속성에 대한 설계도이다. 
    - 실질적인 내용은 없는 property 나 함수의 선언만 들어있다.
    - 프로토콜을 인스턴스화 시키는 것은 불가능하다.
    
```swift
protocol SampleProtocol {
    
    func description(name: String)
}

struct PersonStruct: SampleProtocol {
    
    func description(name: String) {
        print("PersonStruct 의 description 함수입니다.")
        print("name: \(name)")
    }
}

class PersonClass: SampleProtocol {
    
    func description(name: String) {
        print("PersonClass 의 description 함수입니다.")
        print("name: \(name)")
    }
}
```

* 프로토콜에서 선언한 init() 함수가 있을 때, 해당 프로토콜을 구현하는 클래스에서 init() 함수를 정의하려면 앞에 "required" 키워드를 사용해야 한다.
    - 구조체는 "required" 키워드를 사용하지 않는다.

```swift
protocol SampleProtocol {
    
    init()
    init(name: String)
}

struct PersonStruct: SampleProtocol {
    
    var name: String
    
    init() {
        self.name = "STRUCT_JUNYEONG"
    }
    
    init(name: String) {
        self.name = name
    }
}

class PersonClass: SampleProtocol {
    
    var name: String
    
    required init() {
        self.name = "CLASS_JUNYEONG"
    }
    
    required init(name: String) {
        self.name = name
    }
}
```

* Swift 에서는 다중상속을 허용하지 않지만, 하나의 클래스 상속과 프로토콜 구현은 동시에 선언할 수 있다.