> Swift 배운 내용들을 기록하기 위해 작성한 markdown 파일입니다. 앞으로도 공부를 진행해 나가면서 새로운 내용들을 추가할 예정입니다. 내용에 잘못된 부분이 있으면 언제든 피드백 해주시면 감사하겠습니다 :-)


## 변수 (Variables)

* var
    - var 는 Swift 에서 변수를 나타낸다.
    
```swift
var a = 10
a = 20          // 변수는 값 변경이 가능
a = "Hello"     // error: Int 형으로 선언된 변수에 String 등 다른 타입의 리터럴을 저장할 수 없다.

var b           // error: 특정 리터럴로 값을 초기화해주거나, 타입을 선언해야 한다.
var c: String   // String 형 변수를 선언
c = "Hello, Swift!"

print("a: \(a), \(c)")    // a: 20, Hello, Swift!
```
    

## 상수 (Constants)

* let
    - let 은 Swift 에서 상수를 나타낸다.
    - 상수는 한 번 그 값이 초기화되면 값을 변경할 수 없다.

```swift
let a = 10
a = 20      // error: 상수는 한 번 초기화 되면 값 변경이 불가능

let b       // error: 특정 리터럴로 값을 초기화해주거나, 타입을 선언해야 한다.
let c: Int  // Int 형 상수를 선언 
c = 50      // 상수 선언 시 자료형을 명시해놓으면, 나중에 그 값을 초기화할 수 있다.

```
    
> 변수명과 상수명은 한국어, 중국어 등 가리지 않고 어떤 언어로도 사용할 수 있다.
    

## 자료형 (Type)

* 정수를 포현하는 자료형
    - Int
    - UInt (부호가 없는 양의 정수를 표현할 때 사용, unsigned int)
    
* 소수를 표현하는 자료형
    - Double (64bits 부동소수점까지 표현이 가능, 소수점 14자리까지 출력 가능)
    - Float (32bits 부동소수점까지 표현이 가능, 소수점 5자리까지 출력 가능)
    
* 문자를 표현하는 자료형
    - Character (문자 하나만을 저장)
    - String (문자열을 저장)
    - Character 형 변수에 String 리터럴 값을 저장할 수 없다.
    - Character 와 String 모두 "" (큰따옴표) 로 값을 표현한다. '' (작은따옴표) 는 사용하지 않는다.
    
* 참과 거짓을 표현하는 자료형
    - Bool 


## 튜플 (Tuples)

* () (괄호) 안에 다양한 값을 묶어서 하나의 자료형으로 취급할 때 사용하는 자료형이다.

```swift
let errorCode = (230, "null pointer assignment")
print(errorCode.0)
print(errorCode.1)

var normalCode: (Int, String)    // 초기화 없이 선언도 가능하다.
normalCode = (1, "Hello")
print(normalCode.0)
print(normalCode.1)

var warningCode: (code: Int, value: String)     // 선언 시 인덱스에 이름을 부여할 수도 있다.
warningCode.code = 100              // warningCode.0 = 100 과 같다.
warningCode.value = "Test Message"  // warningCode.1 = "Test Message" 와 같다.
print(warningCode.code)         // 100
print(warningCode.value)        // "Test Message"
```

> tuple 선언 시 인덱스에 이름을 부여하면 가독성이 더 좋아질 것 같다.
